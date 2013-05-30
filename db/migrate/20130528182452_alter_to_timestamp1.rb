class AlterToTimestamp1 < ActiveRecord::Migration
  def up
    remove_column :imported_files, :created_at
    remove_column :imported_files, :updated_at
    add_column :imported_files, :created_at, :datetime
    add_column :imported_files, :updated_at, :datetime
  end

  def down
  end
end
