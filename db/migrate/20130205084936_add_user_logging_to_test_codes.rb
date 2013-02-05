class AddUserLoggingToTestCodes < ActiveRecord::Migration
  def change
    change_table :test_codes do |t|
    				t.references :users
    	end
  end
end
