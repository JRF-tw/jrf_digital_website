class CreateMagazines < ActiveRecord::Migration[4.2]
  def change
    create_table :magazines do |t|
      t.string :name
      t.string :volumn
      t.string :image
      t.integer :issue
      t.string :pdf
      t.string :google_play
      t.date :published_at

      t.timestamps null: false
    end
  end
end
