class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :company_name
      t.string :company_contact_full_name
      t.string :company_contact_email
      t.string :company_contact_phone
      t.string :company_description
      t.string :service_technical_authority_full_name
      t.string :service_technical_authority_email
      t.string :service_technical_authority_phone

      t.timestamps
    end
  end
end
