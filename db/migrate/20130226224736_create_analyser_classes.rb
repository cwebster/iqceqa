class CreateAnalyserClasses < ActiveRecord::Migration
  def change
    create_table :analyser_classes do |t|
      t.string :class_type

      t.timestamps
    end
  end
end
