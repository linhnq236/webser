class AddHouseToRegulation < ActiveRecord::Migration[6.0]
  def change
    add_reference :regulations, :house, null: true, foreign_key: true
  end
end
