class AddMarkToReminder < ActiveRecord::Migration[6.0]
  def change
    add_column :reminders, :mark, :bool, :default => false
  end
end
