class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.string :city
      t.string :distric
      t.string :ward
      t.string :address

      t.timestamps
    end
  end
end
