class CreateIqcData < ActiveRecord::Migration
  def change
    create_table :iqc_data do |t|
      t.string :testCode
      t.integer :dataID
      t.string :notes
      t.datetime :dateTimeCreated
      t.string :result
      t.references :iqc
      t.references :test_code
      
      t.timestamps
    end
    add_index :iqc_data, :testCode
  end
end
