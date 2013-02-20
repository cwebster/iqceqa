class QualitySpecification < ActiveRecord::Base
  attr_accessible :bias, :imprecision, :test_code_id, :cvi, :cvw, :goaltype, :desirableTE
  
  belongs_to :testCode
  
  validates_presence_of :goaltype, :test_code_id
  
  before_save :calculate_metrics
  
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
  
  # If we have a biological specification then calculate quality metrics on this basis
  def calculate_metrics
    if self.goaltype == "Biological"
      unless self.cvi.blank? || self.cvw.blank?
        #Calculate various quality metrics
        self.allowableCVoptimal = self.cvi * 0.25
        self.allowableCVdesirable = self.cvi * 0.5
        self.allowableCVminimum = self.cvi * 0.75

        self.allowableBIASoptimal =0.125*(self.allowableCVoptimal**2+self.cvw**2)**0.5
        self.allowableBIASdesirable =0.25*(self.allowableCVdesirable**2+self.cvw**2)**0.5
        self.allowableBIASminimum =0.375*(self.allowableCVminimum**2+self.cvw**2)**0.5

        self.minimumTE =1.65*(0.75*self.cvi**2)+0.375*(self.cvi**2+self.cvw**2)**0.5
        self.desirableTE =1.65*(0.5*self.cvi**2)+0.25*(self.cvi**2+self.cvw**2)**0.5
        self.optimalTE = 1.65*(0.25*self.cvi**2)+0.125*(self.cvi**2+self.cvw**2)**0.5
      end
    end
  end
end
