class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :code
      t.string :name
      t.string :kind

      t.timestamps
    end
  end
end
