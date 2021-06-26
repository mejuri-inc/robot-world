class CreateParts < ActiveRecord::Migration[6.1]
  def change
    create_table :parts do |t|
      t.string :name
      t.boolean :is_defective

      t.timestamps
    end
  end
end
