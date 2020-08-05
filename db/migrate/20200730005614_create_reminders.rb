class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.text :content
      t.date :start_time
      t.date :end_time

      t.timestamps
    end
  end
end
