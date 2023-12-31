# frozen_string_literal: true

require 'rails_helper'

describe MyNewsItemsController do
  before do
    user = create(:user)
    log_in(user)
  end

  let(:representative) { create(:representative) }
  let(:state) { create(:state) }
  let(:county) { create(:county) }
  let(:article) do
    {
      title:       'title',
      link:        'link',
      description: 'description'
    }.to_json
  end

  describe 'when GET new is requested' do
    it 'assigns a new news item as @news_item and renders new' do
      get :new, params: { representative_id: representative.id }
      expect(assigns(:news_item)).to be_a_new(NewsItem)
      attributes_for(:event)
    end
  end

  describe 'when POST create' do
    context 'with valid parameters' do
      it 'creates a new NewsItem' do
        expect do
          post :create,
               params: { news_item:         attributes_for(:news_item).merge(representative_id: representative.id),
                         representative_id: representative.id, article: article }
        end.to change(NewsItem, :count).by(1)
      end
    end
  end

  describe 'when edit, update, or destroy is called' do
    it 'assigns the correct event as @event' do
      news_item = create(:news_item)
      get :edit, params: { id: news_item.id, representative_id: representative.id }
      expect(assigns(:news_item)).to eq(news_item)
    end
  end

  describe 'when editing a news_item' do
    let(:news_item) { create(:news_item) }

    context 'with valid parameters' do
      it 'updates the requested news item' do
        put :update,
            params: { id: news_item.id, news_item: { title: 'Updated Title' },
representative_id: news_item.representative_id }
        news_item.reload
        expect(news_item.title).to eq('Updated Title')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the news item and re-renders the edit template' do
        put :update,
            params: { id: news_item.id, news_item: { title: nil }, representative_id: news_item.representative_id }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:news_item) { create(:news_item) }

    it 'destroys the requested news item' do
      expect do
        delete :destroy, params: { id: news_item.id, representative_id: news_item.representative_id }
      end.to change(NewsItem, :count).by(-1)
    end
  end
end
