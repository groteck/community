class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog_entry

  validates :content, :user_id, :blog_entry_id, :presence => true
end
