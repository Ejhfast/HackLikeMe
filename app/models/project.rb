class Project < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  validates_presence_of :user_id, :category_id, :name, :description
  
end
