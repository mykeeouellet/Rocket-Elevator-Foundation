class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|
      t.string :building_type
      t.integer :served_floor_number
      t.string :column_status
      t.string :column_information
      t.string :column_notes

      t.timestamps
    end
  end
end
