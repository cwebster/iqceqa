class QualitySpecification < ActiveRecord::Base
  attr_accessible :bias, :imprecision, :testCode, :test_code_id
  
  belongs_to :testCode
end
