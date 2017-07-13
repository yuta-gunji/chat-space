FactoryGirl.define do

  factory :group do
    sequence(:name) { |n| "#{Faker::Team.name}"}
  end
end
