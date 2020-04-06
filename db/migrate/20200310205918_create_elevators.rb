class CreateElevators < ActiveRecord::Migration[5.2]
  def change
    create_table :elevators do |t|
      t.integer :elevator_serial_number
      t.string :elevator_model
      t.string :building_type
      t.string :elevator_status
      t.datetime :elevator_commissioning_date
      t.datetime :elevator_last_inspection_date
      t.string :elevator_inspection_certificate
      t.string :elevator_information
      t.string :elevator_notes

      t.timestamps
    end
  end
end
