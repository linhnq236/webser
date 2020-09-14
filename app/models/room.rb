class Room < ApplicationRecord
  mount_uploader :picture, PictureUploader
  # belongs_to :information
  # validates :name, uniqueness: {message: "Tên phòng đã tồn tại"}
  belongs_to :house
end
