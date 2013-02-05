class AddUserLoggingToAnalysers < ActiveRecord::Migration
  def change
    change_table :analysers do |t|
    				t.references :users
    	end
  end
end
