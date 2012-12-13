class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.integer :IQCID
      t.datetime :dateTimeValid
      t.string :notes
      t.string :testCode
      t.float :target
      
      t.references :iqc

      t.timestamps
    end
    
    add_index :targets, :IQCID
    
  end
end
