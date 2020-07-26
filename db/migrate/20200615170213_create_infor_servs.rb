class CreateInforServs < ActiveRecord::Migration[6.0]
  def change
    create_table :infor_servs do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
