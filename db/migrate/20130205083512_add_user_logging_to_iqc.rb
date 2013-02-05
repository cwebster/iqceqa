class AddUserLoggingToIqc < ActiveRecord::Migration
  def change
    change_table :iqcs do |t|
  				t.references :users
  	end
    
    add_index :users, :id
  end
  
  
end
