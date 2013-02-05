class ChangeLogging < ActiveRecord::Base
  attr_accessible :logRecord, :users_id
  
  validates :logRecord, :users_id, :presence => true
end
