class TestCode < ActiveRecord::Base
  attr_accessible :active, :notes, :readcode, :testExpansion, :testCodeText
  has_many :sigmas
  has_many :targets
  has_many :iqc_datums
  has_many :eqas
  
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |specificaiton|
        csv << specificaiton.attributes.values_at(*column_names)
      end
    end
  end
  
  def self.generate_test_codes_from_ams_data
    @generated_testcodes= ImportedQc.all(:group => :testname)
    
    @generated_testcodes.each do |testcode|
      tc = TestCode.new(:testCodeText => testcode.testname, :notes => "Auto generated", :active => 1, :testExpansion => testcode.testname) 
      tc.save
    end
  end
  
  def self.add_test_codes_ams(testname)
    qc = TestCode.new(:testCodeText => testname, :notes => "Auto generated", :active => 1, :testExpansion => testname) 
    qc.save
  
  end
  
end
