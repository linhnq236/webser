class AddTextcolorToApp < ActiveRecord::Migration[6.0]
  def change
    add_column :apps, :textcolor, :string
  end
end
