class AddDateofIqc < ActiveRecord::Migration
  def up
  	add_column :iqc_data, :dateOfIQC, :date
  end

  def down
  end
end
