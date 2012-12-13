class Sigma < ActiveRecord::Base
  attr_accessible :dateTime, :testCode
  
  belongs_to :testCode
end
