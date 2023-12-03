# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :users
  belongs_to :news_items

end
