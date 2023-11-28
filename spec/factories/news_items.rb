# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    title { 'Title' }
    link { 'sample.com' }
    description { 'This is just a sample news description.' }
    issue { 'Climate Change' }
    association :representative
  end
end
