class AddVisitsToRecords < ActiveRecord::Migration
  def change
    add_column :records, :visits, :integer, null: false, default: 0
  end
end
