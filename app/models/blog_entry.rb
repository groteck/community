class BlogEntry < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  has_and_belongs_to_many :tags
  validates :title, :content, :user_id, :presence => true
end
