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
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
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
    news_item= params[:news_item]
    representative_id = news_item[:representative_id]
    issue = news_item[:issue]
    representative_name = Representative.find(representative_id).name

    puts representative_name 

    puts "Here"
    
    query = representative_name
    news_api = News.new("c7c66321690b41adb22f943fa51934fb")

    top_headlines = news_api.get_top_headlines(
      q: 'bitcoin',
      sources: 'bbc-news,the-verge',
      language: 'en'
      )
    

    @top_articles_list = top_headlines.map do |article|
      puts article
      {   
        title: article.title,
        description: article.description,
        link: article.url
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
