class Sigma < ActiveRecord::Base
  attr_accessible :test_code_id, :testname, :sigma ,:dateOfQC,:qcresult, :eqaresult,:dateOfEQA,:allowableCVoptimal,:allowableCVdesirable, :allowableCVminimum,:allowableBIASoptimal, :allowableBIASdesirable, :allowableBIASminimum, :optimalTE,:desirableTE, :minimumTE, :coreOptimal, :coreDesirable, :coreMinimum, :sigmaScoreOptimal, :sigmaScoreDesirable, :sigmaScoreMinimum
  
  belongs_to :testCode
end
