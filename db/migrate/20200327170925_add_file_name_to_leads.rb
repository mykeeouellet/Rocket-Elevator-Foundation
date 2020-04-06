class AddFileNameToLeads < ActiveRecord::Migration[5.2]
  def change
    add_column :leads, :file_name, :string
  end
end
