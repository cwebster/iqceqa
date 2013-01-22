class Drop < ActiveRecord::Migration
  def up
  	remove_column :sigmas, :sigma
  end

  def down
  end
end
