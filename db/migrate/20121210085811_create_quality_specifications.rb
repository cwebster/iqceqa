class CreateQualitySpecifications < ActiveRecord::Migration
  def change
    create_table :quality_specifications do |t|
      t.string :testCode
      t.float :bias
      t.float :imprecision
      t.references :test_code
      t.timestamps
    end
    
    add_index :quality_specifications, :testCode
  end
end
