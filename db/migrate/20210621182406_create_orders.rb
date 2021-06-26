class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :stock, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
