# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'Test Event' }
    association :county
    description { 'This is a sample description.' }
    start_time { Time.zone.now + 1 }
    end_time { Time.zone.now + 2 }
  end
end
