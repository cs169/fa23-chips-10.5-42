# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    provider { User.providers.keys.sample }
    uid { 1 }
    email { 'cs169@berkeley.edu' }
    first_name { 'John' }
    last_name { 'Doe' }
  end
end
