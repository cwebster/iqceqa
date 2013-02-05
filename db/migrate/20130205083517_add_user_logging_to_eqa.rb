class AddUserLoggingToEqa < ActiveRecord::Migration
  def change
     change_table :eqas do |t|
    				t.references :users
    	end

  end
end
