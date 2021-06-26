class CreateOrderChanges < ActiveRecord::Migration[6.1]
  def change
    create_table :order_changes do |t|
      t.references :order, null: false, foreign_key: { on_delete: :cascade }
      t.references :stock, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
