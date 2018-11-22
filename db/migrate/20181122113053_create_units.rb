class CreateUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.string :name
      t.string :kind
      t.integer :rent
      t.integer :capacity
      t.boolean :agency
      t.integer :location_id
      t.string :location_id
    end
    add_index :units, :location_id
  end
end
