class CreatePatterns < ActiveRecord::Migration[4.2]
  def change
    create_table :patterns do |t|
      t.string :name
    end
  end
end
