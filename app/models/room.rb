class Room < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :information
end
