class CreateInformation < ActiveRecord::Migration[6.0]
  def change
    create_table :information do |t|
      t.string :name
      t.boolean :sex
      t.date :birth
      t.string :indentifycard
      t.date :daterange
      t.string :placerange
      t.string :phone1
      t.string :phone2
      t.string :permanent
      t.date :start
      t.float :deposit
      t.text :note

      t.timestamps
    end
  end
end
