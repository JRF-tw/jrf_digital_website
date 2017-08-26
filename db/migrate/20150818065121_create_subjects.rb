class CreateSubjects < ActiveRecord::Migration[4.2]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :icon
      t.integer :order
    end
  end
end
