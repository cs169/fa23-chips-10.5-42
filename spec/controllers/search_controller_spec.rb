# frozen_string_literal: true

require 'rails_helper'

describe SearchController do
  let(:fake_google_service) do
    instance_double("Google::Apis::CivicinfoV2::CivicInfoService")
  end
  before :each do 
    state = State.create!(
      name: "California", 
      symbol: "CA", 
      fips_code: 6, 
      is_territory: 0, 
      lat_min: -124.409591, 
      lat_max: -114.131211, 
      long_min: 32.534156, 
      long_max: -114.131211, 
      created_at: "2023-11-24 23:53:20", 
      updated_at: "2023-11-24 23:53:20"
    )
    county = state.counties.create!(
      name: "Alameda County", 
      state_id: 286, 
      fips_code: 1, 
      fips_class: "H1", 
      created_at: "2023-11-24 23:53:24", 
      updated_at: "2023-11-24 23:53:24"
    )
  end

  describe "valid search" do 
    before :each do 
      allow(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:new).and_return(fake_google_service)
      allow(fake_google_service).to receive(:key=)
      allow(fake_google_service).to receive(:representative_info_by_address).and_return("")
      allow(Representative).to receive(:civic_api_to_representative_params).and_return("")
    end 

    context "when calling search directly" do
      it "renders search view" do
        get :search, params: { address: "Berkeley Way" }
        expect(response).to render_template('representatives/search')
      end
    end
    
    context "when county path is accessed" do
      it "renders search view" do
        get :search_using_county, params: { state_symbol: 'CA', std_fips_code: '001' }
        expect(response).to redirect_to(search_representatives_path(address: "Alameda County, CA"))
      end
    end
  end

  describe "Invalid search" do
    context "invalid state" do
      it "redirects to root" do 
        get :search_using_county, params: { state_symbol: 'QQ', std_fips_code: '001' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to be_present
      end
    end
    context "invalid fips code" do
      it "redirects to root" do 
        get :search_using_county, params: { state_symbol: 'CA', std_fips_code: '10000' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to be_present
      end
    end
    
  end

end
