class AddUserLoggingToChangeLoggings < ActiveRecord::Migration
  def change
      change_table :change_loggings do |t|
      				t.references :users
      	end
  end
end
