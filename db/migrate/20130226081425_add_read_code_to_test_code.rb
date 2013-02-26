class AddReadCodeToTestCode < ActiveRecord::Migration
  def change
    remove_column :test_codes, :testCode
  end
end
