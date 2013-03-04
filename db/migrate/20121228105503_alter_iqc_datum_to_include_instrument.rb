class AlterIqcDatumToIncludeInstrument < ActiveRecord::Migration
  def up
  	  	add_column :iqc_data, :analyser, :string
  end

  def down
  end
end
