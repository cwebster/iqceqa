class Eqa < ActiveRecord::Base
  attr_accessible :bias, :notes, :eqa_scheme_id, :test_code_id
  
  belongs_to :testCode
  belongs_to :EqaScheme
end
