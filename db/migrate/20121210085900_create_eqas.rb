class CreateEqas < ActiveRecord::Migration
  def change
    create_table :eqas do |t|
      t.string :testCode
      t.string :scheme
      t.float :bias
      t.string :notes
      t.datetime :dateTimeCreated
      t.references :test_code
      t.timestamps
    end
    add_index :eqas, :testCode
    
  end
end
