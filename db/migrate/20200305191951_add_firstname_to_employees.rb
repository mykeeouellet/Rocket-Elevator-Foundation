class AddFirstnameToEmployees < ActiveRecord::Migration[5.2]
    def change
      add_column :employees, :firstname, :string, null: false
    end
end