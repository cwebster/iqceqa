class AddUserLoggingToSigmas < ActiveRecord::Migration
  def change
      change_table :sigmas do |t|
      				t.references :users
      	end
  end
end
