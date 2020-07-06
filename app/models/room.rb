class Room < ApplicationRecord
  mount_uploader :picture, PictureUploader
  # belongs_to :information
  belongs_to :house
end
