class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :status
      t.references :car, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
