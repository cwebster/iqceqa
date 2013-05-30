class CreateImportedQcs < ActiveRecord::Migration
  def change
    create_table :imported_qcs do |t|
      t.string :testname
      t.string :analyser
      t.string :qclot
      t.string :qcdate
      t.string :qctime
      t.string :result

      t.timestamps
    end
  end
end
