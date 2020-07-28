class AddBirthToMember < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :birth, :json
  end
end
