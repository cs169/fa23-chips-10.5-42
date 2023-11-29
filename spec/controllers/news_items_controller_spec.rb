# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  describe 'GET index' do
    it 'Sets Represent' do
      rep = Representative.create({ name:    'name',
                                    ocdid:   'ocdid',
                                    title:   'title',
                                    address: 'address',
                                    party:   'party',
                                    photo:   'photo' })
      news_item = NewsItem.create({
          title: 'title',
          link: 'link',
          description: 'description',
          representative_id: rep.id,
          created_at: DateTime.new(2001, 2, 1),
          updated_at: DateTime.new(2002, 9, 1) })
      @representative = rep
      @news_item = news_item
      get :index
      expect(assigns(:news_items)).to eq([news_item])
    end
  end
end
