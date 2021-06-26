class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.decimal :price
      t.decimal :cost
      t.string :model
      t.integer :year
      t.string :assembly_line

      t.timestamps
    end
  end
end
