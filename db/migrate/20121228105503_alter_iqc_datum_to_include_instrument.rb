class AlterIqcDatumToIncludeInstrument < ActiveRecord::Migration
  def up
  	  	change_table :iqc_data do |t|
  			t.add_column :analyser
		end
  end

  def down
  end
end
