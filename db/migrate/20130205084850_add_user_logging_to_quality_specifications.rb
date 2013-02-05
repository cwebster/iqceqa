class AddUserLoggingToQualitySpecifications < ActiveRecord::Migration
  def change
    change_table :quality_specifications do |t|
    				t.references :users
    	end
  end
end
