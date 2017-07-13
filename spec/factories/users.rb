FactoryGirl.define do
  pass = Faker::Internet.password(8)
  factory :user do
    id                    2
    name                  Faker::Name.unique.clear
    email                 Faker::Internet.email
    password              pass
    password_confirmation pass

    trait :for_controller do
      after(:create) do |user|
        user.groups << create_list(:group, 2)
        user.groups.first.messages << create_list(:message, 2, user: user, group: user.groups.first)
      end
    end
  end
end
