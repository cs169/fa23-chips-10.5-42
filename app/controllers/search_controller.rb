# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    address = params[:address]
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    result = service.representative_info_by_address(address: address)
    @representatives = Representative.civic_api_to_representative_params(result)
    render 'representatives/search'
  end


  def search_using_county
    fips_code = params[:std_fips_code]
    state_symbol = params[:state_symbol].upcase

    state = State.find_by(symbol: state_symbol)
    county = state.counties.find_by(fips_code: fips_code) if state

    if county
      address = "#{county.name}, #{state_symbol}"
      redirect_to search_representatives_path(address: address)
    else
      flash[:alert] = 'County or State not found'
      redirect_to root_path
    end
  end
end
