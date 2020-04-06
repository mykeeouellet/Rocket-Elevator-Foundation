class CreateQuote < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :BuildingType
      t.integer :NbrAppt
      t.string :NbrFloors
      t.integer :NbrBassements
      t.integer :NbrElevators
      t.string :ElevatorQuality
      t.float :ElevatorCost
      t.float :InstallationPrice
      t.float :TotalPrice
      t.integer :NbrBusinesses
      t.integer :NbrParking
      t.integer :NbrRentalCompagnies
      t.integer :NbrOccupanrtPerFloor
      t.datetime :WorkingHours
    end
  end
end
