class Regulation < ApplicationRecord
  belongs_to :house
  validates :title, uniqueness: true
end
