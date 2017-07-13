FactoryGirl.define do

  factory :message do
    body        Faker::DragonBall.character
    image     Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png'))
  end
end

