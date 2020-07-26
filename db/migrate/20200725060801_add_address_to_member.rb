class AddAddressToMember < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :address, :json
  end
end
