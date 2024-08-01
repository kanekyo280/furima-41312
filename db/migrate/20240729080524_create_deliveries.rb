class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string :postal_code,   null: false
      t.integer :delivery_area_id,   null: false
      t.string :address_city,   null: false
      t.string :address_house_number,   null: false
      t.string :address_building_name
      t.string :phone_number,   null: false
      t.references :saleslog,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
