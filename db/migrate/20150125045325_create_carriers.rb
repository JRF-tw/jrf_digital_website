class CreateCarriers < ActiveRecord::Migration[4.2]
  def change
    create_table :carriers do |t|
      t.string :name
    end
  end
end
