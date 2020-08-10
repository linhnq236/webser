class AddInformationToPaytherent < ActiveRecord::Migration[6.0]
  def change
    add_reference :paytherents, :information, null: true, foreign_key: true
  end
end
