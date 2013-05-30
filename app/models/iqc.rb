class Iqc < ActiveRecord::Base
  attr_accessible :assigned, :manufacturer, :name, :notes, :id, :code, :lotno, :expirydate, :dateinuse, :datereconstituted, :numberofaliquots, :storagelocation, :storagetemp, :users_id
  
  belongs_to :testCode
  has_many :iqcDatums
  
  def self.generate
    @generated_qc_lots= ImportedQc.all(:group => :qclot)
    
    @generated_qc_lots.each do |qc|
      qc = Iqc.new(:name => qc.qclot, :notes => "Auto generated", :lotno => qc.qclot) 
      qc.save
    end
    
  end
  
end
