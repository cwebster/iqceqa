class Eqa < ActiveRecord::Base
  attr_accessible :bias, :notes, :eqa_scheme_id, :test_code_id, :dateOfEQA, :analyser_id
  
  validates :bias, :eqa_scheme_id, :test_code_id, :dateOfEQA, :analyser_id , :presence => true
  
  belongs_to :TestCode
  belongs_to :EqaScheme
  belongs_to :analyser
end
