class Sigma < ActiveRecord::Base
  attr_accessible :test_code_id, :sigma
  
  belongs_to :testCode
end
