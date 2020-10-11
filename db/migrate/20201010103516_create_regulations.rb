class CreateRegulations < ActiveRecord::Migration[6.0]
  def change
    create_table :regulations do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
