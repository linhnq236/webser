class CreatePaytherents < ActiveRecord::Migration[6.0]
  def change
    create_table :paytherents do |t|
      t.string :senddate
      t.string :receivedate
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
