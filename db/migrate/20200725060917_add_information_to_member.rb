class AddInformationToMember < ActiveRecord::Migration[6.0]
  def change
    add_reference :members, :information, null: true, foreign_key: true
  end
end
