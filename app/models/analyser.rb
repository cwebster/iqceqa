class Analyser < ActiveRecord::Base
  attr_accessible :AnalyserLocation, :AnalyserName, :AnalyserNote, :analyser_types_id
  
  has_many :iqc_datum
  has_many :eqas
  has_one :analyser_type
  
  def self.generate
    @generated_analysers= ImportedQc.all(:group => :analyser)
    
    @generated_analysers.each do |qc|
      qc = Analyser.new(:AnalyserName => qc.analyser, :AnalyserNote => "Auto generated", :analyser_types_id => 1) 
      qc.save
    end
    
  end
  
end
