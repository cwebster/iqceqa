class CreateFormBuilders < ActiveRecord::Migration
  def change
    create_table :form_builders do |t|
      t.string :form_name
      t.string :description
      t.timestamps
      t.references :eqa_schemes
    end
  end
end
