# frozen_string_literal: true

class NewsItemsController < ApplicationController
  before_action :set_representative
  before_action :set_news_item, only: %i[show]

  def index
    @news_items = @representative.news_items
  end

  def show; end

  def top_articles
    # Fetch top 5 articles from the News API
    @top_articles = NewsService.search_top_articles(@representative.id, params[:issue])
  end

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
