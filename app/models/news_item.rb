# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  # has_many :ratings, dependent: :delete_all
  validates :title, presence: true
  validates :link, presence: true
  validates :representative_id, presence: true
  validates :issue, inclusion: { in: ->(news_item) { NewsItem.all_issues }, allow_nil: true }

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  def self.all_issues
    ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare', 'Abortion',
     'Student Loans', 'Gun Control', 'Unemployment', 'Climate Change', 'Homelessness',
     'Racism', 'Tax Reform', 'Net Neutrality', 'Religious Freedom', 'Border Security',
     'Minimum Wage', 'Equal Pay']
  end
end
