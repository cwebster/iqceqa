class IqcDatum < ActiveRecord::Base
  attr_accessible :dataID, :dateTimeCreated, :notes, :result, :iqc_id, :test_code_id
  
  belongs_to :testCode
  belongs_to :iqc
end
