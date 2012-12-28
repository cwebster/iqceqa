class DropDataIdFromiqcData < ActiveRecord::Migration
  def up
  			remove_column :iqc_data, :dataID
  			remove_column :iqc_data, :iqc_data_id
  end

  def down
  end
end
