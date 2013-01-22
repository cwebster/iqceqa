class AddCalculationFieldstoIqCdatum < ActiveRecord::Migration
  def up
  	add_column :iqc_data, :usedInCalculation, :bool
  	add_column :iqc_data, :usedInCalculationDate, :date
  end

  def down
  end
end
