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
  		
  		from_date = eqa.dateOfEQA.to_date - 30.days
  		to_date = eqa.dateOfEQA.to_date + 30.days
  		
  		@iqcs = IqcDatum.where("test_code_id = ? and analyser_id = ?  and  exclude_point =0 and dateOfIQC >= ? AND dateOfIQC <= ?", eqa.test_code_id, eqa.analyser_id, from_date, to_date).order("dateOfIQC ASC").group("iqc_id")
      
  		
  		@iqcs.each do |iqc|
  		
  			# get the iqc data via lot, analyser and test name
  			@iqc_data = IqcDatum.where("test_code_id = ? and analyser_id = ?  and exclude_point =0 and iqc_id = ? and dateOfIQC >= ? AND dateOfIQC <= ?", eqa.test_code_id, eqa.analyser_id, iqc.iqc_id, from_date, to_date).order("dateOfIQC ASC")
  			@overalliqcs = IqcDatum.where("test_code_id = ?   and  exclude_point =0 and dateOfIQC >= ? AND dateOfIQC <= ?", eqa.test_code_id, from_date, to_date).order("dateOfIQC ASC").group("iqc_id")
  			
  		
  			#calculate %CV for group
			result = @iqc_data.map {|i| i.result.to_f }
			stats = DescriptiveStatistics::Stats.new(result)
			puts result
      
      #calculate %CV Overall for IQC across all analysers
			resultoverall = @overalliqcs.map {|i| i.result.to_f }
			statsoverall = DescriptiveStatistics::Stats.new(resultoverall)
			puts resultoverall
      
      @overallmean = statsoverall.mean
      @overallsd = statsoverall.standard_deviation
        
			@mean = stats.mean
			@sd = stats.standard_deviation
			
			if @sd.nil?
				@cv = 0.001
        @sd = 0.00000000001
				
				next
			else			
				@cv = (@sd /@mean)*100
          
				puts @cv
				puts @sd
				puts @mean
			end
			
			if @overallsd.nil?
				 @overallcv = 0.001
         @overallsd = 0.00000000001
				
				next
			else			
				@overallcv = (@overallsd /@overallmean)*100
          
				puts @overallcv
				puts @overallsd
				puts @overallmean
			end
      
			
				@results = Hash.new
                @results1 = Hash.new
				
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
		          
              
              if @cv > 0
                @sigmaScoreOptimal = (@optimalTE.to_f - eqa.bias.to_f)/@cv.to_f
		            @sigmaScoreDesirable = (@desirableTE.to_f - eqa.bias.to_f)/@cv.to_f
		            @sigmaScoreMinimum = (@minimumTE.to_f - eqa.bias.to_f)/@cv.to_f
              else
                @sigmaScoreOptimal = (@optimalTE.to_f - eqa.bias.to_f)/0.00000001
		            @sigmaScoreDesirable = (@desirableTE.to_f - eqa.bias.to_f)/0.00000001
		            @sigmaScoreMinimum = (@minimumTE.to_f - eqa.bias.to_f)/0.00000001
              end
              
              
              if @overallcv > 0
                @overallsigmaScoreOptimal = (@optimalTE.to_f - eqa.bias.to_f)/@overallcv.to_f
		            @overallsigmaScoreDesirable = (@desirableTE.to_f - eqa.bias.to_f)/@overallcv.to_f
		            @overallsigmaScoreMinimum = (@minimumTE.to_f - eqa.bias.to_f)/@overallcv.to_f
              else
                @overallsigmaScoreOptimal = (@optimalTE.to_f - eqa.bias.to_f)/0.00000001
		            @overallsigmaScoreDesirable = (@desirableTE.to_f - eqa.bias.to_f)/0.00000001
		            @overallsigmaScoreMinimum = (@minimumTE.to_f - eqa.bias.to_f)/0.00000001
              end
		
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
              
		          #Build hash of Overall sigma results
		          @results1["test_code_id"] = iqc.test_code_id
		          @results1["analyser"] = "Overall"
		          @results1["testname"] = @testname
		          @results1["dateOfQC"] = iqc.dateOfIQC
		          @results1["qcresult"] = @cv.to_f
		          @results1["eqaresult"] = eqa.bias
		          @results1["dateOfEQA"] = eqa.dateOfEQA
		          @results1["allowableCVoptimal"] = @allowableCVoptimal
		          @results1["allowableCVdesirable"] = @allowableCVdesirable
		          @results1["allowableCVminimum"] = @allowableCVminimum
		          @results1["allowableBIASoptimal"] = @allowableBIASoptimal
		          @results1["allowableBIASdesirable"] = @allowableBIASdesirable
		          @results1["allowableBIASminimum"] = @allowableBIASminimum
		          @results1["optimalTE"] = @optimalTE
		          @results1["desirableTE"] = @desirableTE
		          @results1["minimumTE"] = @minimumTE
		          @results1["sigmaScoreOptimal"] = @overallsigmaScoreOptimal
		          @results1["sigmaScoreDesirable"] = @overallsigmaScoreDesirable
		          @results1["sigmaScoreMinimum"] = @overallsigmaScoreMinimum
		          @calcsigmas.push(@results1)
		          
				elsif @qs.goaltype =="TE"
		          @results["test_code_id"] = iqc.test_code_id
		          @results["analyser"] = Analyser.find(iqc.analyser_id).AnalyserName
		          @results["testname"] = @testname
		          @results["dateOfQC"] = iqc.dateOfIQC
		          @results["qcresult"] = iqc.result
		          @results["eqaresult"] = eqa.bias
		          @results["dateOfEQA"] = eqa.dateOfEQA
		          @results["desirableTE"] = @qs.desirableTE
		          @results["sigmaScoreDesirable"] = @sigmaScoreDesirable
		          @calcsigmas.push(@results)
              
		          @results["test_code_id"] = iqc.test_code_id
		          @results["analyser"] = "Overall"
		          @results["testname"] = @testname
		          @results["dateOfQC"] = iqc.dateOfIQC
		          @results["qcresult"] = iqc.result
		          @results["eqaresult"] = eqa.bias
		          @results["dateOfEQA"] = eqa.dateOfEQA
		          @results["desirableTE"] = @qs.desirableTE
		          @results["sigmaScoreDesirable"] = @overallsigmaScoreDesirable
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

