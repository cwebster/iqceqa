class AddCalculationFieldstoSigma < ActiveRecord::Migration
  def up
  	add_column :sigmas,:dateOfQC, :date
  	add_column :sigmas,:qcresult, :double
  	add_column :sigmas,:eqaresult, :double
  	add_column :sigmas,:dateOfEQA, :date
  	add_column :sigmas,:allowableCVoptimal, :double
  	add_column :sigmas,:allowableCVdesirable, :double
  	add_column :sigmas,:allowableCVminimum, :double
  	add_column :sigmas,:allowableBIASoptimal, :double
  	add_column :sigmas,:allowableBIASdesirable, :double
  	add_column :sigmas,:allowableBIASminimum, :double
  	add_column :sigmas,:optimalTE, :double
  	add_column :sigmas,:desirableTE, :double
  	add_column :sigmas,:minimumTE, :double
  	add_column :sigmas,:sigmaScoreOptimal, :double
  	add_column :sigmas,:sigmaScoreDesirable, :double
  	add_column :sigmas,:sigmaScoreMinimum, :double
  end

  def down
  end
end
