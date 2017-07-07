namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    User.create!(first_name: 'Pes',
                 last_name: 'Mitko',
                 email: 'example@mail.org',
                 password: 'password',
                 password_confirmation: 'password')
    99.times do
      first_name  = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = Faker::Internet.email
      password  = 'password'
      User.create!(first_name: first_name,
                   last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end