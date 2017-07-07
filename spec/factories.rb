FactoryGirl.define do
  factory :role do
    
  end
  factory :user do
    sequence(:first_name)     { |n| "Name #{n}" }
    sequence(:last_name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password 'password'
    password_confirmation 'password'
  end
end