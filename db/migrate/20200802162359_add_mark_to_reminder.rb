class AddMarkToReminder < ActiveRecord::Migration[6.0]
  def change
    add_column :reminders, :mark, :integer, :default => 0
  end
end
