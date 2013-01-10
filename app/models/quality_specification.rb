class QualitySpecification < ActiveRecord::Base
  attr_accessible :bias, :imprecision, :test_code_id, :cvi, :cvw, :goaltype
  
  belongs_to :testCode
  
  validates_presence_of :goaltype, :test_code_id
  
	def self.import(file)
  		spreadsheet = open_spreadsheet(file)
  		header = spreadsheet.row(1)
  		(2..spreadsheet.last_row).each do |i|
    		row = Hash[[header, spreadsheet.row(i)].transpose]
    	quality_specification = find_by_id(row["id"]) || new
    	quality_specification.attributes = row.to_hash.slice(*accessible_attributes)
    	quality_specification.save!
  end
end

	def self.open_spreadsheet(file)
  		case File.extname(file.original_filename)
  			when ".csv" then Csv.new(file.path, nil, :ignore)
  			when ".xls" then Excel.new(file.path, nil, :ignore)
  			when ".xlsx" then Excelx.new(file.path, nil, :ignore)
  		else raise "Unknown file type: #{file.original_filename}"
  		end
	end
  
def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |specificaiton|
      csv << specificaiton.attributes.values_at(*column_names)
    end
  end
end
  
  
end
