class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true, :on => :create
  validates_presence_of :password, :on => :create
end
