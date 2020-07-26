class Service < ApplicationRecord
   validates :name, uniqueness: {message: "Tên dịch vụ đã tồn tại."}
end
