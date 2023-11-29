# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'name' }
    description { 'description' }
    start_time { DateTime.new(2000, 1, 1) }
    end_time { DateTime.new(2000, 1, 1) }
    created_at { DateTime.new(2000, 1, 1) }
    updated_at { DateTime.new(2000, 1, 1) }
    association :county
  end
end
