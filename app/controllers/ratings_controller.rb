# frozen_string_literal: true

class RatingsController < ApplicationController
  def create
    user_id = params[:user_id]
    news_item_id = params[:news_item_id]
    rating = params[:rating]
    Rating.create({ user_id: user_id, news_item_id: news_item_id, rating: rating })
  end
end
