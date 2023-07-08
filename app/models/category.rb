class Category < ApplicationRecord
  belongs_to :user
  has_many :operations

  validates :name, :icon, presence: true
end
