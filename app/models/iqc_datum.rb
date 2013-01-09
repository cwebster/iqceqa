class IqcDatum < ActiveRecord::Base
  by_star_field :dateTimeCreated
  attr_accessible :dateTimeCreated, :notes, :result, :iqc_id, :test_code_id, :analyser_id
  
  has_many :TestCodes
  belongs_to :iqc
  belongs_to :analyser
end
