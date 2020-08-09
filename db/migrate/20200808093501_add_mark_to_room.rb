class AddMarkToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :mark, :integer, :default => 0
  end
end
