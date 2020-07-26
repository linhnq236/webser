class AddInformationToInforServ < ActiveRecord::Migration[6.0]
  def change
    add_reference :infor_servs, :information, null: true, foreign_key: true
  end
end
