class AlterIqcDatum < ActiveRecord::Migration
  	def up

  		change_table :iqc_data do |t|
  			t.remove :testCode
		end
	end
  

  def down
  
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
