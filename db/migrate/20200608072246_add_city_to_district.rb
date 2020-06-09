class AddCityToDistrict < ActiveRecord::Migration[6.0]
  def change
    add_reference :districts, :city, null: true, foreign_key: true
  end
end
