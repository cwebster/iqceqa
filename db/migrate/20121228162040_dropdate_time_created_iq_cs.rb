class DropdateTimeCreatedIqCs < ActiveRecord::Migration
  def up
  	remove_column :iqcs, :dateTimeCreated
  end

  def down
  end
end
