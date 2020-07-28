class AddInformationToRoom < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :information, null: true, foreign_key: true
  end
end
