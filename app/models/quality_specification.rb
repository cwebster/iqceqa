class QualitySpecification < ActiveRecord::Base
  attr_accessible :bias, :imprecision, :testCode
  
  belongs_to :testCode
end
