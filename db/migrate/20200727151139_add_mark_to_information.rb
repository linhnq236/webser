class AddMarkToInformation < ActiveRecord::Migration[6.0]
  def change
    add_column :information, :mark, :bool, :default => false
  end
end
