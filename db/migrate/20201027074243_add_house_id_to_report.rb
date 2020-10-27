class AddHouseIdToReport < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :house_id, :integer
  end
end
