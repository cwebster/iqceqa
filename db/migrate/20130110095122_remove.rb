class Remove < ActiveRecord::Migration
  def up
  	remove_column :change_loggings, :dateTimeLogged
  end

  def down
  end
end
