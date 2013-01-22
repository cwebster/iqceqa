class Sigma < ActiveRecord::Base
  attr_accessible :test_code_id, :testname ,:dateOfQC,:qcresult, :eqaresult,:dateOfEQA,:allowableCVoptimal,:allowableCVdesirable, :allowableCVminimum,:allowableBIASoptimal, :allowableBIASdesirable, :allowableBIASminimum, :optimalTE,:desirableTE, :minimumTE, :sigmaScoreOptimal, :sigmaScoreDesirable, :sigmaScoreMinimum
  
  belongs_to :testCode
end
