class CreateKeywords < ActiveRecord::Migration[4.2]
  def change
    create_table :keywords do |t|
      t.string :name
    end
    add_index :keywords, :name, unique: true
  end
end
