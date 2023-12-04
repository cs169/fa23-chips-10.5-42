# frozen_string_literal: true

require 'rails_helper'

describe Rating do
  it 'creates new rating' do
    user = create(:user)
    news_item = create(:news_item)
    expect(described_class.add_rating({ user_id: user.id, news_item_id: news_item.id, rating: 1.0 }).rating).to eq(1.0)
  end
end
