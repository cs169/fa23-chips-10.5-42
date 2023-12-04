# frozen_string_literal: true

require 'news-api'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_issues_list, only: %i[new edit]
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    article = JSON.parse(params[:article])
    params[:news_item] = {title: article["title"], link: article["link"], issue: params[:issue], description: article["description"],representative_id: params[:representative_id]}
    @news_item = NewsItem.find_by(link: article["link"])
    if @news_item.nil?
      @news_item = NewsItem.new(news_item_params)
    end
    @representative = Representative.find(params[:representative_id])
    if @news_item.save!
      if !params[:rating].nil?
        Rating.add_rating({ rating: params[:rating], user_id: session[:current_user_id], news_item_id: @news_item.id })
      end
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
    # redirect_to blank_page_path
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def top_articles
    news_item = params[:news_item]
    @news_item = params[:news_item]
    representative_id = news_item[:representative_id]
    @issue = news_item[:issue]
    @representative_name = Representative.find(representative_id).name

    
    news_api = News.new("c1ef19e62bd54cc9a6703339d81ed8dc")
    query = @representative_name + " " + @issue
    
    top_headlines = news_api.get_everything(q: query,
    language: 'en',
    sortBy: 'relevancy')
    if top_headlines.length > 5 
      top_headlines = top_headlines.slice(0, 5)
    end

    @top_articles_list = top_headlines.map do |article|
      {
        title:       article.title,
        description: article.description,
        link:        article.url
      }
    end
  end

  def get_top_articles
    redirect_to add_my_top_news_item_path
  end

  private

  def set_issues_list
    @issues_list = NewsItem.all_issues
  end

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :issue, :description, :link, :representative_id)
  end
end
