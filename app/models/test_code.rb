class TestCode < ActiveRecord::Base
  attr_accessible :active, :notes, :testCode, :testExpansion, :testCodeText
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
  
end
