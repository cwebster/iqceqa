class TestCode < ActiveRecord::Base
  attr_accessible :active, :notes, :testCode, :testExpansion, :testCodeText
  has_many :sigmas
  has_many :targets
  has_many :iqc_datums
  has_many :eqas
  
end
