class AddCarToParts < ActiveRecord::Migration[6.1]
  def change
    add_reference :parts, :car, null: false, foreign_key: { on_delete: :cascade }
  end
end
