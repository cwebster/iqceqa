class AddTransfrimportedQCs < ActiveRecord::Migration
  def up
    add_column :imported_files, :transferred, :integer
  end

  def down
  end
end
