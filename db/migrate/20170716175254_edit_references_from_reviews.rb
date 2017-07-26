class EditReferencesFromReviews < ActiveRecord::Migration[5.0]
  def change
    remove_reference :reviews, :hotel
    remove_reference :reviews, :user
    add_reference :reviews, :rate, index: true
  end
end
