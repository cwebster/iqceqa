class AddExcludeToIqcData < ActiveRecord::Migration
  def change
  	add_column :iqc_data, :exclude_point, :integer

  end
end
