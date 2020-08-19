class Information < ApplicationRecord
  # has_many :rooms
  has_many :paytherents
  has_many :services
  has_many :reports
end
