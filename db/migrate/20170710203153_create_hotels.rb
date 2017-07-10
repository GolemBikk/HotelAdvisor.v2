class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.string  :title,               null: false, default: ''
      t.boolean :breakfast_included,  null: false, default: false
      t.boolean :wifi_included,       null: false, default: false
      t.string  :room_description,    null: false, default: ''
      t.integer :price_for_room,      null: false, default: 0
      t.string  :address,             null: false, default: ''
      t.string  :photo,               null: true
      t.string  :status,              null: false, default: ''

      t.timestamps
    end

    add_index :hotels, :title
    add_index :hotels, :address
    add_reference :hotels, :user, index: true
  end
end
