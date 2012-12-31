class AlterSigmaTable < ActiveRecord::Migration
  def up
  	remove_column :sigmas, :dateTime
  end

  def down
  end
end
