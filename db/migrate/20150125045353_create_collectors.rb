class CreateCollectors < ActiveRecord::Migration[4.2]
  def change
    create_table :collectors do |t|
      t.string :name
    end
  end
end
