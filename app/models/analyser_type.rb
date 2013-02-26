class AnalyserType < ActiveRecord::Base
  attr_accessible :analyser_type_name, :analyser_type_description, :analyser_picture, :analyser_classes_id
  
  has_many :analysers
  
  has_attached_file :analyser_picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
