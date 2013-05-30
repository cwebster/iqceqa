class ImportedQc < ActiveRecord::Base
  attr_accessible :analyser, :qcdate, :qclot, :qctime, :result, :testname, :level, :transferred
end
