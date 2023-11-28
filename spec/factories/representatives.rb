# frozen_string_literal: true

FactoryBot.define do
  factory :representative do
    name { 'John' }
    ocdid { 'ocdid' }
    title { 'Representative' }
    address { '1 Berkeley Way' }
    party { 'Independent' }
    photo { 'sample.jpg' }
  end
end
