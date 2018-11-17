FactoryBot.define do
  factory :user do
    username { Faker::TwinPeaks.character }
    password { 'password' }
  end
end
