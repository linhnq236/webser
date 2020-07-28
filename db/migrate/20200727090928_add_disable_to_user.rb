class AddDisableToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :disable, :bool, :default=> false
  end
end
