class AlterToTimestamp2 < ActiveRecord::Migration
  def up
    remove_column :imported_files, :created_at
    remove_column :imported_files, :updated_at
    add_column :imported_files, :created_at, :datetime, :NULL => FALSE, :default =>  0
    add_column :imported_files, :updated_at, :datetime, :NULL => FALSE, :default => 0
    
  end

  def down
  end
end
