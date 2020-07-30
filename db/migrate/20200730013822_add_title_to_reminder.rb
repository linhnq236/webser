class AddTitleToReminder < ActiveRecord::Migration[6.0]
  def change
    add_column :reminders, :title, :string
  end
end
