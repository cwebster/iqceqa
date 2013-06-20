class Sigma < ActiveRecord::Base
  attr_accessible :test_code_id, :testname , :analyser, :dateOfQC,:qcresult, :eqaresult,:dateOfEQA,:allowableCVoptimal,:allowableCVdesirable, :allowableCVminimum,:allowableBIASoptimal, :allowableBIASdesirable, :allowableBIASminimum, :optimalTE,:desirableTE, :minimumTE, :sigmaScoreOptimal, :sigmaScoreDesirable, :sigmaScoreMinimum
  
  belongs_to :testCode
  
  def week
    self.created_at.strftime("%W")
  end

  def month
    self.created_at.strftime("%y%m")
  end
  
  
  def self.calculateSigmas
  	
  	@eqas = Eqa.all
  	 
  	@calcsigmas = Array.new
  	
  	# For each EQA record found, find, IQC and analyser and calculate a sigma score
  	
  	@eqas.each do |eqa| 
  	
  		# get the different lots of IQc for test and analyser
  		
  		from_date = eqa.dateOfEQA.to_date - 20.days
  		to_date = eqa.dateOfEQA.to_date + 20.days
  		
  		@iqcs = IqcDatum.where("test_code_id = ? and analyser_id = ? and usedInCalculation =0 and  exclude_point =0 and dateOfIQC >= ? AND dateOfIQC <= ?", eqa.test_code_id, eqa.analyser_id, from_date, to_date).order("dateOfIQC ASC").group("iqc_id")
  		
  		@iqcs.each do |iqc|
  		
  			# get the iqc data via lot, analyser and test name
  			@iqc_data = IqcDatum.where("test_code_id = ? and analyser_id = ? and usedInCalculation =0 and exclude_point =0 and iqc_id = ? and dateOfIQC >= ? AND dateOfIQC <= ?", eqa.test_code_id, eqa.analyser_id, iqc.iqc_id, from_date, to_date).order("dateOfIQC ASC")
  			
  			
  		
  			#calculate %CV for group
			result = @iqc_data.map {|i| i.result.to_f }
			stats = DescriptiveStatistics::Stats.new(result)
			puts result
        
			@mean = stats.mean
			@sd = stats.standard_deviation
			
			if @sd.nil?
				@cv = 0
				
				next
			else			
				@cv = (@sd /@mean)*100
          
				puts @cv
				puts @sd
				puts @mean
			end
			
			
				@results = Hash.new
				
				#Get Testname
				@testname = TestCode.find(iqc.test_code_id).testExpansion
				
				@qs = QualitySpecification.where("test_code_id = ?", iqc.test_code_id).first
				
				#Get QualitySpecification for Test if no Quality Spec break from loop
				if @qs.nil?
				  next 
				end
				
				#If we have a biological quality specification then calcualate sigma
				if @qs.goaltype =="Biological"
				
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
		
		          @sigmaScoreOptimal = (@optimalTE.to_f - eqa.bias.to_f)/@cv.to_f
		          @sigmaScoreDesirable = (@desirableTE.to_f - eqa.bias.to_f)/@cv.to_f
		          @sigmaScoreMinimum = (@minimumTE.to_f - eqa.bias.to_f)/@cv.to_f
		
		
		          #Build hash of sigma results
		          @results["test_code_id"] = iqc.test_code_id
		          @results["analyser"] = Analyser.find(iqc.analyser_id).AnalyserName
		          @results["testname"] = @testname
		          @results["dateOfQC"] = iqc.dateOfIQC
		          @results["qcresult"] = @cv.to_f
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
		          
				elsif @qs.goaltype =="TE"
		          @results["test_code_id"] = iqc.test_code_id
		          @results["analyser"] = Analyser.find(iqc.analyser_id).AnalyserName
		          @results["testname"] = @testname
		          @results["dateOfQC"] = iqc.dateOfIQC
		          @results["qcresult"] = iqc.result
		          @results["eqaresult"] = eqa.bias
		          @results["dateOfEQA"] = eqa.dateOfEQA
		          @results["desirableTE"] = @qs.desirableTE
		          @results["sigmaScoreDesirable"] = (@qs.desirableTE.to_f - eqa.bias.to_f)/@cv.result.to_f
		          @calcsigmas.push(@results)
		          
				end # end of quality specification
				
				# mark all EQA and IQCs used as used in calculations
	          iqc.usedInCalculation = 1
	          iqc.usedInCalculationDate = Date.today
	          iqc.save
			
			
		end #end of loop of IQC
	end # end of EQA loop
	
	# add all calculated sigma scores to database
	
	@calcsigmas.each do |eqa| 
		Sigma.create(eqa)
	end
	
	#Log sigma calculation
	changeLogging = ChangeLogging.new(:logRecord => 'SIGMA', :users_id => '-1')
	changeLogging.save
  
  end



end

