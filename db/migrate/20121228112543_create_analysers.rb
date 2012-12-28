class CreateAnalysers < ActiveRecord::Migration
  def change
    create_table :analysers do |t|
      t.string :AnalyserName
      t.text :AnalyserNote
      t.string :AnalyserLocation
      t.references :iqc_data

      t.timestamps
    end
    add_index :analysers, :iqc_data_id
  end
end
