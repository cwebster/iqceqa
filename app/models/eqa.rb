class Eqa < ActiveRecord::Base
  attr_accessible :bias, :notes, :eqa_scheme_id, :test_code_id, :dateOfEQA, :analyser_id
  
  validates_presence_of :bias, :eqa_scheme_id, :test_code_id, :dateOfEQA, :analyser_id , :presence => true
  
  belongs_to :TestCode
  belongs_to :EqaScheme
  belongs_to :analyser
  has_many :form_config
  
  def self.bulk_new(attributes = {}, current_user)
    eqa = attributes[:eqa]
    
    @errors_array = Array.new
    
    eqa[:bias_test_code].each {|key, value|
      test_code_id =key
      eqa_record= Eqa.new
      eqa_record[:eqa_scheme_id]= eqa[:eqa_scheme_id]
      eqa_record[:test_code_id]= key
      eqa_record[:bias]= value
      eqa_record[:dateOfEQA]= eqa[:dateOfEQA]
      eqa_record[:analyser_id]= eqa[:analyser_id]
      eqa_record.users_id = current_user.id
      
      if eqa_record.valid?
        eqa_record.save
      else
        eqa_record.errors.full_messages.each do |message|
        return false
      end
          
      end
        
      
    }
    
    changeLogging = ChangeLogging.new(:logRecord => 'EQA Record Created', :users_id => current_user.id)
    changeLogging.save
    
    return true
  end
  
end
