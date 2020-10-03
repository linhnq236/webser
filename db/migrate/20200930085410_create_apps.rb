class CreateApps < ActiveRecord::Migration[6.0]
  def change
    create_table :apps do |t|
      t.string :title
      t.text :text
      t.string :image
      t.string :backgroundColor

      t.timestamps
    end
  end
end
