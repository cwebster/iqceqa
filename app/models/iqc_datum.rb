class IqcDatum < ActiveRecord::Base
  by_star_field :dateOfIQC
  attr_accessible :dateOfIQC, :notes, :result, :iqc_id, :test_code_id, :analyser_id, :usedInCalculation, :usedInCalculationDate
  
  validates :dateOfIQC, :result, :iqc_id, :test_code_id, :analyser_id, :presence => true
  
  has_many :TestCodes
  belongs_to :iqc
  belongs_to :analyser
  
  
  #import iqc records, theres probably a way better way to do this
  def self.transfer_ams_qc
    @not_imported = ImportedQc.where("transferred IS NULL or transferred = 0")
    
    @not_imported.each do |amsqc|
      @an = Analyser.where("AnalyserName = ?", amsqc.analyser)
      
      @an.each do |analyser|
        @anname = analyser.id
      end
      
      @tn = TestCode.where("testCodeText = ?", amsqc.testname)
      
      @tn.each do |tc|
        @tcname = tc.id
      end
      
      @qc = Iqc.where("lotno = ?", amsqc.qclot)
      
      @qc.each do |qcs|
        @qcid = qcs.id
      end
      
      newtime = amsqc.qctime[0,2] + ":" + amsqc.qctime[2,2]
      
      datetoconvert = amsqc.qcdate + " " + newtime
      
      tc = IqcDatum.new(:dateOfIQC => datetoconvert, :notes => "Auto generated", :iqc_id => @qcid, :test_code_id => @tcname, :analyser_id => @anname, :result => amsqc.result) 
      
      tc.save
      
    end
    
    #mark records as imported
    @not_imported.each do |amsqc|
        ImportedQc.update(amsqc.id, :transferred => 1)
    end
  
  
  end
  
  
  
end
