class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :interventions, :author_id, :author
  end
end
