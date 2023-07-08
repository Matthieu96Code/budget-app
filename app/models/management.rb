class Management < ApplicationRecord
  belongs_to :operation
  belongs_to :category
end
