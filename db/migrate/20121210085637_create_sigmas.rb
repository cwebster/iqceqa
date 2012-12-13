class CreateSigmas < ActiveRecord::Migration
  def change
    create_table :sigmas do |t|
      t.string :testCode
      t.datetime :dateTimeCreated
      t.float :sigma

      t.references :test_code
      
      t.timestamps
    end
    
    add_index :sigmas, :testCode
  end
end
