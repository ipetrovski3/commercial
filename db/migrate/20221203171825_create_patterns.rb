class CreatePatterns < ActiveRecord::Migration[7.0]
  def change
    create_table :patterns do |t|
      t.string :name
      t.integer :season
      t.references :brand, foreign_key: true
      t.timestamps
    end
  end
end
