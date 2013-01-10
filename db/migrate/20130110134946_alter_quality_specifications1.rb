class AlterQualitySpecifications1 < ActiveRecord::Migration
  def up
  	add_column :quality_specifications, :goaltype, :string
  end

  def down
  end
end
