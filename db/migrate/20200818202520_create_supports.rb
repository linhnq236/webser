class CreateSupports < ActiveRecord::Migration[6.0]
  def change
    create_table :supports do |t|
      t.integer :status, :default=>0
      t.integer :voice, :default=>0

      t.timestamps
    end
  end
end
