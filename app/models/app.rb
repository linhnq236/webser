class App < ApplicationRecord
  mount_uploader :image
  validates :title, presence: true
end
