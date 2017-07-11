namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    User.create!(first_name:            'Alexander',
                 last_name:             'Iundin',
                 email:                 'dorian.adret@gmail.com',
                 password:              '123456',
                 password_confirmation: '123456')
    User.first.add_role :admin
    30.times do
      first_name  = Faker::Name.first_name
      last_name   = Faker::Name.last_name
      email       = Faker::Internet.email
      password    = '654321'
      User.create!(first_name: first_name,
                   last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all.limit(10)
    users.each do |user|
      5.times do
        title = Faker::Name.title
        address = "#{Faker::Address.city} #{Faker::Address.country}"
        price_for_room = 50
        room_description = Faker::Lorem.sentences(5)
        breakfast_included = [true, false].sample
        wifi_included = [true, false].sample
        Hotel.create!(title: title,
                      address: address,
                      room_description: room_description,
                      price_for_room: price_for_room,
                      breakfast_included: breakfast_included,
                      wifi_included: wifi_included,
                      user_id: user.id)
      end
    end
  end
end