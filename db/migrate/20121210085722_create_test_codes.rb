class CreateTestCodes < ActiveRecord::Migration
  def change
    create_table :test_codes do |t|
      t.string :testCodeText
      t.string :testExpansion
      t.string :notes
      t.boolean :active
      t.integer :testCode

      t.timestamps
    end
  end
end
