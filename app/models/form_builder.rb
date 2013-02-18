class FormBuilder < ActiveRecord::Base
  attr_accessible :form_name, :description, :eqa_scheme_id, :form_configs_attributes, :_destroy
  attr_accessor :_destroy

  has_many :form_configs, :dependent => :destroy
  
  accepts_nested_attributes_for :form_configs, allow_destroy: true
  
  validates_presence_of :form_name, :description, :eqa_scheme_id
end
