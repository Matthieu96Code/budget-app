class Category < ApplicationRecord
  belongs_to :user
  # has_many :operations
  has_many :managements
  has_many :operations, through: :managements
end
