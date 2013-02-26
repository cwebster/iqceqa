class CreateAnalyserTypes < ActiveRecord::Migration
  def change
    create_table :analyser_types do |t|
      t.string :analyser_type_name
      t.string :analyser_type_description
      t.string :analyser_type_picture_link
      t.timestamps
    end
  end
end
