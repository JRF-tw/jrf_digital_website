class AddColumnsToRecords < ActiveRecord::Migration
  def change
    add_column :records, :statistics, :integer, null: false, default: 0
    add_column :records, :serial_no, :string
    change_column :records, :quantity, 'integer USING CAST(quantity AS integer)', null: true
  end
end
