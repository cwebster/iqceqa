class CreateImportedFiles < ActiveRecord::Migration
  def change
    create_table :imported_files do |t|
      t.string :filename

      t.timestamps
    end
  end
end
