class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.json :name
      t.json :birth
      t.json :sex
      t.json :indentifycard
      t.json :phone1
      t.json :phone2

      t.timestamps
    end
  end
end
