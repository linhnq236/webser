class CreateDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :districts do |t|
      t.string :code
      t.string :name
      t.string :kind

      t.timestamps
    end
  end
end
