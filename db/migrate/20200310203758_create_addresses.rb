class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address_type
      t.string :address_status
      t.string :street_number
      t.string :street_name
      t.string :suite_or_apartment
      t.string :city
      t.string :postal_code
      t.string :country
      t.string :address_notes

      t.timestamps
    end
  end
end
