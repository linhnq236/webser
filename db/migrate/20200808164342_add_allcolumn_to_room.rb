class AddAllcolumnToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :oldelectric, :float
    add_column :rooms, :newelectric, :float
    add_column :rooms, :oldwater, :float
    add_column :rooms, :newwater, :float
  end
end
