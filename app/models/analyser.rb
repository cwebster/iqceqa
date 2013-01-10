class Analyser < ActiveRecord::Base
  attr_accessible :AnalyserLocation, :AnalyserName, :AnalyserNote
  
  has_many :iqc_datum
  has_many :eqas
  
end
