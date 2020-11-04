class CreateCatImages < ActiveRecord::Migration[5.2]
  def change
    create_table :cat_images do |t|
      t.references :cat, foreign_key: true
      t.string :alt_text
      t.integer :position

      t.timestamps
    end
  end
end
