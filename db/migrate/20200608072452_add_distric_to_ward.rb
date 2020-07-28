class AddDistricToWard < ActiveRecord::Migration[6.0]
  def change
    add_reference :wards, :district, null: true, foreign_key: true
  end
end
