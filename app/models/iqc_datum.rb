class IqcDatum < ActiveRecord::Base
  attr_accessible :dataID, :notes, :result, :iqc_id, :test_code_id, :analyser_id
  
  has_many :TestCodes
  belongs_to :iqc
  belongs_to :analyser
end
