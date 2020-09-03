class AddUserToReport < ActiveRecord::Migration[6.0]
  def change
    add_reference :reports, :user, null: true, foreign_key: true
  end
end
