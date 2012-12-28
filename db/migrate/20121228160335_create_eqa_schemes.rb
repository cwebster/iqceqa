class CreateEqaSchemes < ActiveRecord::Migration
  def change
    create_table :eqa_schemes do |t|
      t.string :name
      t.text :address
      t.text :contact
      t.string :website

      t.timestamps
    end
  end
end
