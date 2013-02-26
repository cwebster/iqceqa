class Analyser < ActiveRecord::Base
  attr_accessible :AnalyserLocation, :AnalyserName, :AnalyserNote, :analyser_types_id
  
  has_many :iqc_datum
  has_many :eqas
  has_one :analyser_type
  
end
