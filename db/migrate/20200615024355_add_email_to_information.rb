class AddEmailToInformation < ActiveRecord::Migration[6.0]
  def change
    add_column :information, :email, :string
  end
end
