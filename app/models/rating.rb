class Rating < ApplicationRecord
  belongs_to :news_items
  belongs_to :user

  def county_names_by_id
    county&.state&.counties&.map { |c| [c.name, c.id] }.to_h || []
  end
end
