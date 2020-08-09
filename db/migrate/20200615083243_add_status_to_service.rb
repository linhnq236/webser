class AddStatusToService < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :status, :integer, :default => 0
  end
end
