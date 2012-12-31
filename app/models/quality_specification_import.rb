class QualitySpecificationImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_quality_specificaitons.map(&:valid?).all?
      imported_quality_specificaitons.each(&:save!)
      true
    else
      imported_quality_specificaitons.each_with_index do |quality_specification, index|
        quality_specification.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_quality_specifications
    @imported_quality_specifications ||= load_imported_quality_specifications
  end

  def load_imported_quality_specifications
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      quality_specification = QualitySpecification.find_by_id(row["id"]) || QualitySpecification.new
      quality_specification.attributes = row.to_hash.slice(*QualitySpecification.accessible_attributes)
      quality_specification.save!
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end