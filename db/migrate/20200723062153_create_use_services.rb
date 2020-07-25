class CreateUseServices < ActiveRecord::Migration[6.0]
  def change
    create_table :use_services do |t|
      t.json :service_id
      t.json :amount

      t.timestamps
    end
  end
end
