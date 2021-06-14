class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price, precision: 10, scale: 2
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
