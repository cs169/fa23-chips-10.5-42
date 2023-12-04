# frozen_string_literal: true

class NewsItemsController < ApplicationController
  before_action :set_representative
  before_action :set_news_item, only: %i[show]
  
  def index
    @ratings = []
    @news_items = @representative.news_items
    @news_items.each do |item|
      ratings = Rating.where(news_item_id: item.id)
      sum = 0
      count = 0
      ratings.each do |r|
        sum += r.rating
        count += 1
      end
      if count == 0
        @ratings.push(0)
      else
        @ratings.push(sum/count)
      end
    end
  end

  def show; end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end
end
