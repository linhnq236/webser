class AddUserToReminder < ActiveRecord::Migration[6.0]
  def change
    add_reference :reminders, :user, null: true, foreign_key: true
  end
end
