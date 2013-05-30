class AlterToTimestamp4 < ActiveRecord::Migration
  def up

    add_column :imported_files, :created_at, :timestamp, :NULL => FALSE, :default => Time.now
  end

  def down
  end
end
