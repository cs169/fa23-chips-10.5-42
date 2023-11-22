# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all
  validates :name, presence: true
  validates :ocdid, presence: true
  validates :title, presence: true

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      address = ''
      unless official.address.nil?
        addy = official.address[0]
        address = [addy.line1, addy.city, addy.state, addy.zip].join(' ')
      end 

      rep = Representative.find_or_initialize_by(name: official.name)
      rep.update({name: official.name, title: title_temp, address: address, party: official.party, photo: official.photo_url})
      reps.push(rep)
    end
    reps
  end
end