class AddVisitsToRecords < ActiveRecord::Migration[4.2]
  def change
    add_column :records, :visits, :integer, null: false, default: 0
  end
end
