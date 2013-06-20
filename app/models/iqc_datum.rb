class IqcDatum < ActiveRecord::Base
  by_star_field :dateOfIQC
  attr_accessible :dateOfIQC, :notes, :result, :iqc_id, :test_code_id, :analyser_id, :usedInCalculation, :usedInCalculationDate, :exclude_point
  
  validates :dateOfIQC, :result, :iqc_id, :test_code_id, :analyser_id, :exclude_point, :presence => true
  
  has_many :TestCodes
  belongs_to :iqc
  belongs_to :analyser
  
  
  #import iqc records, theres probably a way better way to do this
  def self.transfer_ams_qc
    @not_imported = ImportedQc.where("transferred IS NULL or transferred = 0")
    
    @not_imported.each do |amsqc|
      @an = Analyser.where("AnalyserName = ?", amsqc.analyser).first
      
      if @an.nil?
      	an = Analyser.new(:AnalyserName => amsqc.analyser, :AnalyserNote => "Auto generated", :analyser_types_id => 1) 
	  	an.save
	  	next 
      else
      	@analyserid =  @an.id
      end

      @tn = TestCode.where("testCodeText = ?", amsqc.testname).first
      
      if @tn.nil?
      	tc = TestCode.new(:testCodeText => amsqc.testname, :notes => "Auto generated", :active => 1, :testExpansion => amsqc.testname) 
	  	tc.save
	  	next 
      else
      	@tcid = @tn.id
      end
      
      @qc = Iqc.where("lotno = ?", amsqc.qclot).first
      
      if @qc.nil?
      	qc = Iqc.new(:name => amsqc.qclot, :notes => "Auto generated", :lotno => amsqc.qclot) 
	  	qc.save
	  	next 
      else
      	@qcid = @qc.id
      end
      
      newtime = amsqc.qctime[0,2] + ":" + amsqc.qctime[2,2]
      
      datetoconvert = amsqc.qcdate + " " + newtime
      
      tc = IqcDatum.new(:dateOfIQC => datetoconvert, :notes => "Auto generated", :iqc_id => @qcid, :test_code_id => @tcid, :analyser_id => @analyserid, :result => amsqc.result, :exclude_point => 0) 
      
      tc.save
      
    end
    
    #mark records as imported
    @not_imported.each do |amsqc|
        ImportedQc.update(amsqc.id, :transferred => 1)
    end
  
  
  end
  
  
  
end
