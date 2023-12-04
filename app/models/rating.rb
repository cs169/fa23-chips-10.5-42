# frozen_string_literal: true

class Rating < ApplicationRecord

  def self.add_rating(info)
    user_id = info[:user_id]
    news_item_id = info[:news_item_id]
    rating = info[:rating]
    user = User.find(user_id)
    news_item = NewsItem.find(news_item_id)
    Rating.create!({ user_id_id: user_id, news_item_id_id: news_item_id, rating: rating })
  end
end
