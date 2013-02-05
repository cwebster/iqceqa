class Iqc < ActiveRecord::Base
  attr_accessible :assigned, :manufacturer, :name, :notes, :id, :code, :lotno, :expirydate, :dateinuse, :datereconstituted, :numberofaliquots, :storagelocation, :storagetemp, :users_id
  
  belongs_to :testCode
  has_many :iqcDatums
end
