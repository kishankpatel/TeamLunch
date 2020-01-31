FactoryBot.define do
  factory :event_place do
    event_id { "" }
    place_id { "" }
    voter_ids { "MyString" }
    is_finalize { false }
    finalized_by { "" }
  end
end
