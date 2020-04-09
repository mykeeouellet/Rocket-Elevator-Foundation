class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.references :author, foreign_key: { to_table: :employees }
      t.references :customer, foreign_key: true
      t.references :building, foreign_key: true
      t.references :battery, foreign_key: true
      t.references :column, foreign_key: true
      t.references :elevator, foreign_key: true
      t.references :employee, foreign_key: true
      t.datetime :starting_time, :default => nil
      t.datetime :ending_time, :default => nil
      t.string :result, :default => "Incomplete"
      t.text :report
      t.string :status, :default => "Pending"

      t.timestamps
    end
  end
end
