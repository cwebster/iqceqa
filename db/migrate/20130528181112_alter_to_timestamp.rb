class AlterToTimestamp < ActiveRecord::Migration
  def up

    add_column :imported_files, :created_at, :timestamp
    add_column :imported_files, :updated_at, :timestamp
  end

  def down
  end
end
