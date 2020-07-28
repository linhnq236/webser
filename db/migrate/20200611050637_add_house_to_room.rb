class AddHouseToRoom < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :house, null: false, foreign_key: true
  end
end
