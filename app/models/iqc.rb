class Iqc < ActiveRecord::Base
  attr_accessible :assigned, :manufacturer, :name, :notes, :id
  
  belongs_to :testCode
  has_many :iqcDatums
end
