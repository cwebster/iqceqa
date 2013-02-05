class AddUserLoggingToIqcDatum < ActiveRecord::Migration
  def change
    change_table :iqc_data do |t|
    				t.references :users
    end
  end
end
