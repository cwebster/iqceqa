class SigmasController < ApplicationController
  # GET /sigmas
  # GET /sigmas.json
  def index
    @sigmas = Sigma.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sigmas }
    end
  end

  # GET /sigmas/1
  # GET /sigmas/1.json
  def show
    @sigma = Sigma.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sigma }
    end
  end

  # GET /sigmas/new
  # GET /sigmas/new.json
  def new
    @sigma = Sigma.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sigma }
    end
  end

  # GET /sigmas/1/edit
  def edit
    @sigma = Sigma.find(params[:id])
  end

  # POST /sigmas
  # POST /sigmas.json
  def create
    @sigma = Sigma.new(params[:sigma])

    respond_to do |format|
      if @sigma.save
        format.html { redirect_to @sigma, notice: 'Sigma was successfully created.' }
        format.json { render json: @sigma, status: :created, location: @sigma }
      else
        format.html { render action: "new" }
        format.json { render json: @sigma.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sigmas/1
  # PUT /sigmas/1.json
  def update
    @sigma = Sigma.find(params[:id])

    respond_to do |format|
      if @sigma.update_attributes(params[:sigma])
        format.html { redirect_to @sigma, notice: 'Sigma was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sigma.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sigmas/1
  # DELETE /sigmas/1.json
  def destroy
    @sigma = Sigma.find(params[:id])
    @sigma.destroy

    respond_to do |format|
      format.html { redirect_to sigmas_url }
      format.json { head :no_content }
    end
  end
  
  
  def self.calculateSigmas
  
  # check when last sigma calculation was done and then get the IQC and EQA records after this date
  
  	@calculationDate = ChangeLogging.find(:last, :order => "created_at ASC", :conditions => [ "logRecord = ?", 'SIGMA'])
  	
  	# @iqcs = IqcDatum.where("dateOfIQC > ?", @calculationDate.created_at.to_date)
  	@eqas = Eqa.where("dateOfEQA > ?", @calculationDate.created_at.to_date)
  
  	@calcsigmas = Array.new
  	
  # For each EQA record found, find, IQC and analyser and calculate a sigma score
  	
  	@eqas.each do |eqa| 
  	
  		@iqcs = IqcDatum.by_month(eqa.dateOfEQA.month, :year => eqa.dateOfEQA.year).where("test_code_id = ? and analyser_id = ? and usedInCalculation =0", eqa.test_code_id, eqa.analyser_id).order("dateOfIQC ASC")
			
			@iqcs.each do |iqc| 
				@results = Hash.new
				
				#Get Testname
				@testname = TestCode.find(iqc.test_code_id).testExpansion
				
				#Get QualitySpecification for Test
				@qs = QualitySpecification.where("test_code_id = ?", iqc.test_code_id).first
				
				#Calculate various quality metrics
				@allowableCVoptimal = @qs.cvi * 0.25
				@allowableCVdesirable = @qs.cvi * 0.5
				@allowableCVminimum = @qs.cvi * 0.75
				
				@allowableBIASoptimal =0.125*(@allowableCVoptimal**2+@qs.cvw**2)**0.5
				@allowableBIASdesirable =0.25*(@allowableCVdesirable**2+@qs.cvw**2)**0.5
				@allowableBIASminimum =0.375*(@allowableCVminimum**2+@qs.cvw**2)**0.5
				
				@minimumTE =1.65*(0.75*@qs.cvi**2)+0.375*(@qs.cvi**2+@qs.cvw**2)**0.5
				@desirableTE =1.65*(0.5*@qs.cvi**2)+0.25*(@qs.cvi**2+@qs.cvw**2)**0.5
				@optimalTE = 1.65*(0.25*@qs.cvi**2)+0.125*(@qs.cvi**2+@qs.cvw**2)**0.5
			
				@sigmaScoreOptimal = (@optimalTE.to_f - eqa.bias.to_f)/iqc.result.to_f
				@sigmaScoreDesirable = (@desirableTE.to_f - eqa.bias.to_f)/iqc.result.to_f
				@sigmaScoreMinimum = (@minimumTE.to_f - eqa.bias.to_f)/iqc.result.to_f
				
				
				#Build hash of sigma results
				@results["test_code_id"] = iqc.test_code_id
				@results["testname"] = @testname
				@results["dateOfQC"] = iqc.dateOfIQC
				@results["qcresult"] = iqc.result
				@results["eqaresult"] = eqa.bias
				@results["dateOfEQA"] = eqa.dateOfEQA
				@results["allowableCVoptimal"] = @allowableCVoptimal
				@results["allowableCVdesirable"] = @allowableCVdesirable
				@results["allowableCVminimum"] = @allowableCVminimum
				@results["allowableBIASoptimal"] = @allowableBIASoptimal
				@results["allowableBIASdesirable"] = @allowableBIASdesirable
				@results["allowableBIASminimum"] = @allowableBIASminimum
				@results["optimalTE"] = @optimalTE
				@results["desirableTE"] = @desirableTE
				@results["minimumTE"] = @minimumTE
				@results["sigmaScoreOptimal"] = @sigmaScoreOptimal
				@results["sigmaScoreDesirable"] = @sigmaScoreDesirable
				@results["sigmaScoreMinimum"] = @sigmaScoreMinimum
				@calcsigmas.push(@results)
				
				# mark all EQA and IQCs used as used in calculations
				iqc.usedInCalculation = 1
				iqc.usedInCalculationDate = Date.today
				iqc.save
			end
	end
	
	# add all calculated sigma scores to database
	
	@calcsigmas.each do |eqa| 
		Sigma.create(eqa)
	end
  
  end
  
  
  
  
end
