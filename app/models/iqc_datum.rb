class IqcDatum < ActiveRecord::Base
  by_star_field :dateOfIQC
  attr_accessible :dateOfIQC, :notes, :result, :iqc_id, :test_code_id, :analyser_id
  
  validates :dateOfIQC, :result, :iqc_id, :test_code_id, :analyser_id, :presence => true
  
  has_many :TestCodes
  belongs_to :iqc
  belongs_to :analyser
end
