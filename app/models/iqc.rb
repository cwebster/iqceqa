class Iqc < ActiveRecord::Base
  attr_accessible :IQCID, :assigned, :datetimecreated, :manufacturer, :name, :notes
  
  belongs_to :testCode
  has_many :iqcDatum
end
