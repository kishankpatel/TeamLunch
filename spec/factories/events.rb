FactoryBot.define do
  factory :event do
    name { "MyString" }
    description { "MyText" }
    date { "2020-02-01 00:10:43" }
    created_by { 1 }
  end
end
