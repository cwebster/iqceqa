class AddLevelToImportedQCs < ActiveRecord::Migration
  def change
    add_column :imported_qcs,:level, :string
  end
end
