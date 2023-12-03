# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :users
  belongs_to :news_items

  def add_rating(info)
    user_id = info.user_id
    news_item_id = info.news_item_id
    rating = info.rating
    Rating.create({ user_id: user_id, news_item_id: news_item_id, rating: rating })
  end
end
