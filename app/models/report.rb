class Report < ApplicationRecord
  belongs_to :information
  # validates :rep_content, presence: {message: "Nội dung phản hồi không được để trống"}
end
