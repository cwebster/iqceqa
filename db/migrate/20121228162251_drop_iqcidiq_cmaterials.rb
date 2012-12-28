class DropIqcidiqCmaterials < ActiveRecord::Migration
  def up
  	remove_column :iqcs, :IQCID
  end

  def down
  end
end
