class AlterQualitySpecifications < ActiveRecord::Migration
  def up
  	add_column :quality_specifications, :cvi, :double
  	add_column :quality_specifications, :cvw, :double
  end

  def down
  end
end
