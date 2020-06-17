class AddStatusToService < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :status, :bool
  end
end
