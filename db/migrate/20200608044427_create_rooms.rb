class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :cost
      t.string :length
      t.string :width
      t.integer :amount
      t.integer :allow
      t.text :description

      t.timestamps
    end
  end
end
