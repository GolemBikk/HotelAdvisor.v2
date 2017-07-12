class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :title, null: false, default: ''
      t.string :text,  null: false, default: ''

      t.timestamps
    end

    add_reference :reviews, :user, index: true
    add_reference :reviews, :hotel, index: true
  end
end
