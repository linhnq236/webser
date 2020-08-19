class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.text :rep_content
      t.integer :mark, :default=>0

      t.timestamps
    end
  end
end
