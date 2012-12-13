class Target < ActiveRecord::Base
  attr_accessible :IQCID, :dateTimeValid, :notes, :testCode
  
  belongs_to :testCode
end
