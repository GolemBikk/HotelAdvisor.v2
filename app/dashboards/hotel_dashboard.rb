require "administrate/base_dashboard"

class HotelDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    roles: Field::HasMany,
    user: Field::BelongsTo,
    id: Field::Number,
    title: Field::String,
    breakfast_included: Field::Boolean,
    wifi_included: Field::Boolean,
    room_description: Field::String,
    price_for_room: Field::Number,
    address: Field::String,
    photo: Field::String,
    status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :id,
    :title,
    :address
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :id,
    :title,
    :breakfast_included,
    :wifi_included,
    :room_description,
    :price_for_room,
    :address,
    :photo,
    :status,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :title,
    :breakfast_included,
    :wifi_included,
    :room_description,
    :price_for_room,
    :address,
    :photo,
    :status,
  ].freeze

  # Overwrite this method to customize how hotels are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(hotel)
  #   "Hotel ##{hotel.id}"
  # end
end