class FormConfig < ActiveRecord::Base
  attr_accessible :order, :form_builder_id, :test_codes_id
  
  belongs_to :form_builder
  has_many :eqas, :foreign_key => 'eqa_scheme_id'
  
  accepts_nested_attributes_for :eqas, allow_destroy: true
end
