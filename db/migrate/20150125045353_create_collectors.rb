class CreateCollectors < ActiveRecord::Migration
  def change
    create_table :collectors do |t|
      t.string :name
    end
  end
end
