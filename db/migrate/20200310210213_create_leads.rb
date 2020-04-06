class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.string :lead_full_name
      t.string :lead_company_name
      t.string :lead_email
      t.string :lead_phone
      t.string :project_name
      t.string :project_description
      t.string :department_of_service
      t.string :lead_message

      t.timestamps
    end
  end
end
