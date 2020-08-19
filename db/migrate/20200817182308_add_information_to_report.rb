class AddInformationToReport < ActiveRecord::Migration[6.0]
  def change
    add_reference :reports, :information, null: true, foreign_key: true
  end
end
