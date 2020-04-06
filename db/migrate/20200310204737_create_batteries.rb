class CreateBatteries < ActiveRecord::Migration[5.2]
  def change
    create_table :batteries do |t|
      t.string :building_type
      t.string :battery_status
      t.datetime :battery_commissioning_date
      t.datetime :battery_last_inspection_date
      t.string :battery_operation_certificate
      t.string :battery_information
      t.string :battery_notes

      t.timestamps
    end
  end
end
