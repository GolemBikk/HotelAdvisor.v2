class AddColumnToHotels < ActiveRecord::Migration[5.0]
  def change
    add_column :hotels, :star_rating, :integer, null: false, default: 0
  end
end
