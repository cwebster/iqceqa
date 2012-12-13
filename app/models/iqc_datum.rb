class IqcDatum < ActiveRecord::Base
  attr_accessible :dataID, :dateTime, :notes, :result, :testCode
  
  belongs_to :testCode
  belongs_to :iqc
end
