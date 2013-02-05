class Sigma < ActiveRecord::Base
  attr_accessible :test_code_id, :testname , :analyser, :dateOfQC,:qcresult, :eqaresult,:dateOfEQA,:allowableCVoptimal,:allowableCVdesirable, :allowableCVminimum,:allowableBIASoptimal, :allowableBIASdesirable, :allowableBIASminimum, :optimalTE,:desirableTE, :minimumTE, :sigmaScoreOptimal, :sigmaScoreDesirable, :sigmaScoreMinimum
  
  belongs_to :testCode
  
  reportable :avg_sigma_optimal_week, :aggregation => :average, :grouping => :week, :date_column => :dateOfQC, :value_column => :sigmaScoreOptimal, :limit => 50
  
  reportable :avg_sigma_desirable_week, :aggregation => :average, :grouping => :week, :date_column => :dateOfQC, :value_column => :sigmaScoreDesirable, :limit => 50
  
  reportable :avg_sigma_minimum_week, :aggregation => :average, :grouping => :week, :date_column => :dateOfQC, :value_column => :sigmaScoreMinimum, :limit => 50
  
  reportable :sigma_records, :aggregation => :count

  
  def week
    self.created_at.strftime("%W")
  end

  def month
    self.created_at.strftime("%y%m")
  end
  
  
  def self.calculateSigmas
  
  # check when last sigma calculation was done and then get the IQC and EQA records after this date
  #	@calculationDate = ChangeLogging.find(:last, :order => "created_at ASC", :conditions => [ "logRecord = ?", 'SIGMA'])
  	
  	# @iqcs = IqcDatum.where("dateOfIQC > ?", @calculationDate.created_at.to_date)
  	
  	 # get all EQA instead or do by date
  	# @eqas = Eqa.where("dateOfEQA > ?", @calculationDate.created_at.to_date)
  	
  	@eqas = Eqa.all
  	 
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
				
				#If we have a biological quality specification then calcualate sigma
				if @qs.goaltype ="biological"
				
          #Calculate various quality metrics
          @allowableCVoptimal = @qs.allowableCVoptimal
          @allowableCVdesirable = @qs.allowableCVdesirable
          @allowableCVminimum = @qs.allowableCVminimum

          @allowableBIASoptimal =@qs.allowableBIASoptimal
          @allowableBIASdesirable =@qs.allowableBIASdesirable
          @allowableBIASminimum =@qs.allowableBIASminimum

          @minimumTE =@qs.minimumTE
          @desirableTE =@qs.desirableTE
          @optimalTE = @qs.optimalTE

          @sigmaScoreOptimal = (@optimalTE.to_f - eqa.bias.to_f)/iqc.result.to_f
          @sigmaScoreDesirable = (@desirableTE.to_f - eqa.bias.to_f)/iqc.result.to_f
          @sigmaScoreMinimum = (@minimumTE.to_f - eqa.bias.to_f)/iqc.result.to_f


          #Build hash of sigma results
          @results["test_code_id"] = iqc.test_code_id
          @results["analyser"] = Analyser.find(iqc.analyser_id).AnalyserName
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
	end
	
	# add all calculated sigma scores to database
	
	@calcsigmas.each do |eqa| 
		Sigma.create(eqa)
	end
	
	#Log sigma calculation
	changeLogging = ChangeLogging.new(:logRecord => 'SIGMA', :users_id => '-1')
  changeLogging.save
  
  end



end

