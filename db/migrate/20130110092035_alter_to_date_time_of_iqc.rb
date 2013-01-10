class AlterToDateTimeOfIqc < ActiveRecord::Migration
  def up
  	change_column :iqc_data, :dateOfIQC, :datetime
  end

  def down
  end
end
