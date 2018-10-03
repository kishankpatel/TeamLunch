FactoryBot.define do
  factory :place do
    name     { Faker::Name.name }
    address  { Faker::Address.street_address }
    created_by  { 1 }
  end
end
