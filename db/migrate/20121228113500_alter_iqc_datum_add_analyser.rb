class AlterIqcDatumAddAnalyser < ActiveRecord::Migration
  def up
  			remove_column :iqc_data, :analyser_id

  			change_table :iqc_data do |t|
  				t.references :analyser
  			end
			add_index :iqc_data, :analyser_id
  end

  def down
  end
end
