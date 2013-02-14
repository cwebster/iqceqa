class FormConfig < ActiveRecord::Base
  attr_accessible :order, :form_builder_id, :test_codes_id
  
  belongs_to :form_builder

  
end
