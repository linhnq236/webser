class House < ApplicationRecord
  belongs_to :city
  belongs_to :district
  belongs_to :ward
end
