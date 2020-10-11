class House < ApplicationRecord
  belongs_to :city
  belongs_to :district
  belongs_to :ward
  has_many :rooms
  has_many :users
  has_many :regulations
end
