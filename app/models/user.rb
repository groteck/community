class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :access_level
  has_secure_password  
  validates_presence_of :password, :on => :create 
  validates_presence_of :email, :on => :create
  has_many :blogs
  has_many :comments
end
