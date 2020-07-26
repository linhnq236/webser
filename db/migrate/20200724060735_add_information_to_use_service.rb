class AddInformationToUseService < ActiveRecord::Migration[6.0]
  def change
    add_reference :use_services, :information, null: false, foreign_key: true
  end
end
