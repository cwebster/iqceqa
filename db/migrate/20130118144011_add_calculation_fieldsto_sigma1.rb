class AddCalculationFieldstoSigma1 < ActiveRecord::Migration
  def up
  	add_column :sigmas,:testname, :string
  end

  def down
  end
end
