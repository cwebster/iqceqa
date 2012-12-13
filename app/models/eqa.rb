class Eqa < ActiveRecord::Base
  attr_accessible :bias, :dateTimeCreated, :notes, :scheme, :testCode
  
  belongs_to :testCode

end
