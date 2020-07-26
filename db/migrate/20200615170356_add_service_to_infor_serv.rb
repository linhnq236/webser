class AddServiceToInforServ < ActiveRecord::Migration[6.0]
  def change
    add_reference :infor_servs, :service, null: true, foreign_key: true
  end
end
