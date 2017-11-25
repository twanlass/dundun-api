class List < ActiveRecord::Base
  # disable STI
  self.inheritance_column = :_type_disabled
  
  validates :title, presence: true

  belongs_to :user
  has_many :items, dependent: :destroy
end
