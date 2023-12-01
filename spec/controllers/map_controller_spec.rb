# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapController, type: :controller do
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET state' do
    state = State.create({
                           name:         'name',
                           symbol:       'CA',
                           fips_code:    1,
                           is_territory: false,
                           lat_min:      0.0,
                           lat_max:      10.0,
                           long_min:     0.0,
                           long_max:     10.0,
                           created_at:   DateTime.new(2001, 2, 1),
                           updated_at:   DateTime.new(2002, 9, 1)
                         })
    it 'renders the state template' do
      allow(State).to receive(:find_by).and_return(state)
      get :state, params: { state_symbol: state.symbol }
      expect(response).to render_template('state')
    end

    it 'redirects to root path' do
      get :state, params: { state_symbol: state.symbol }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET county' do
    state = State.create({
                           name:         'name',
                           symbol:       'CA',
                           fips_code:    1,
                           is_territory: false,
                           lat_min:      0.0,
                           lat_max:      10.0,
                           long_min:     0.0,
                           long_max:     10.0,
                           created_at:   DateTime.new(2001, 2, 1),
                           updated_at:   DateTime.new(2002, 9, 1)
                         })
    county = County.create({
                             name:       'Alameda County',
                             state_id:   state.id,
                             fips_code:  1,
                             fips_class: 'H1'
                           })

    it 'renders the county template' do
      allow(State).to receive(:find_by).and_return(state)
      allow(County).to receive(:find_by).and_return(county)
      get :county, params: { state_symbol: state.symbol, std_fips_code: 1 }
      expect(response).to render_template('county')
    end

    it 'redirects to root path' do
      allow(State).to receive(:find_by).and_return(state)
      get :county, params: { state_symbol: state.symbol, std_fips_code: 1 }
      expect(response).to redirect_to(root_path)
    end
  end
end
