class AddDateofEqa2 < ActiveRecord::Migration
  def up
  	remove_column :iqc_data, :dateTimeCreated
  end

  def down
  end
end
