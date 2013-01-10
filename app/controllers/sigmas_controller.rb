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
  
  def checkLastCalculationDate
  	@calculationDate = ChangeLogging.find(:last, :order => "created_at ASC", :conditions => [ "logRecord = ?", 'SIGMA'])
  	
  	# @iqcs = IqcDatum.where("dateOfIQC > ?", @calculationDate.created_at.to_date)
  	@eqas = Eqa.where("dateOfEQA > ?", @calculationDate.created_at.to_date)
  	
  	@results = Array.new
  	
  	@eqas.each do |eqa| 
  	
  		@iqcs = IqcDatum.by_month(eqa.dateOfEQA.month, :year => eqa.dateOfEQA.year).where("test_code_id = ? and analyser_id = ?", eqa.test_code_id, eqa.analyser_id).order("dateOfIQC ASC")
			
			@iqcs.each do |iqc| 
			
				@testname = TestCode.find(iqc.test_code_id).testExpansion
				
				@qualitySpecification = QualitySpecification.where("test_code_id = ?", iqc.test_code_id)
				
				@allowableCVoptimal = @qualitySpecification.cvi * 0.25
				@allowableCVdesirable = @qualitySpecification.cvi * 0.5
				@allowableCVminimum = @qualitySpecification.cvi * 0.75
				
				@allowableBIASoptimal =0.125*(@allowableCVoptimal^2+@qualitySpecification.cvw^2)^0.5
				@allowableBIASdesirable =0.25*(@allowableCVdesirable^2+@qualitySpecification.cvw^2)^0.5
				@allowableBIASminimum =0.375*(@allowableCVminimum^2+@qualitySpecification.cvw^2)^0.5
				
				@minimumTE =1.65*(0.75*@qualitySpecification.cvi^2)+0.375*(@qualitySpecification.cvi^2+qualitySpecification.cvw^2)^0.5
				@desirableTE =1.65*(0.5*@qualitySpecification.cvi^2)+0.25*(@qualitySpecification.cvi^2+qualitySpecification.cvw^2)^0.5
				@optimalTE = 1.65*(0.25*@qualitySpecification.cvi^2)+0.125*(qualitySpecification.cvi^2+qualitySpecification.cvw^2)^0.5
			
				@sigmaScoreOptimal = (@optimalTE - eqa.bias)/iqc.result
				@sigmaScoreDesirable = (@desirableTE - eqa.bias)/iqc.result
				@sigmaScoreMinimum = (@minimumTE - eqa.bias)/iqc.result
				
				@results.push(@testName, @allowableCVoptimal, @allowableCVdesirable, @allowableCVminimum, @allowableBIASoptimal, @allowableBIASdesirable,@allowableBIASminimum, @optimalTE, @desirableTE, @minimumTE, @sigmaScoreOptimal, @sigmaScoreDesirable, @sigmaScoreMinimum)
			end
	end
  	
  	respond_to do |format|
  	  format.html # index.html.erb
  	  format.json { head :no_content  }
  	end
  
  end
  
  
  
  
end
