class AddMoneyToPaytherent < ActiveRecord::Migration[6.0]
  def change
    add_column :paytherents, :money, :float, :default=> 0
  end
end
