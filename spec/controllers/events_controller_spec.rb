# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET index' do
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
    event = Event.create!({
                            name:        'name',
                            description: 'description',
                            county_id:   county.id,
                            start_time:  Date.today + 1,
                            end_time:    Date.today + 3,
                            created_at:  DateTime.new(2001, 2, 1),
                            updated_at:  DateTime.new(2002, 9, 1)
                          })

    it 'renders index view' do
      get :index
      expect(response).to render_template('index')
    end

    it 'filters events by state-only' do
      allow(State).to receive(:find_by).and_return(state)
      allow(@state).to receive(:counties).and_return([county])
      param = { 'filter-by': 'state-only', state: 'CA' }
      get :index, params: param
      expect(response).to render_template('index')
    end

    it 'filters events' do
      allow(State).to receive(:find_by).and_return(state)
      allow(County).to receive(:find_by).and_return(county)
      param = { 'filter-by': 'not-nil', state: 'CA' }
      get :index, params: param
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    state = State.create!({
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
    event = Event.create!({
                            name:        'name',
                            description: 'description',
                            county_id:   county.id,
                            start_time:  Date.today + 1,
                            end_time:    Date.today + 3,
                            created_at:  DateTime.new(2001, 2, 1),
                            updated_at:  DateTime.new(2002, 9, 1)
                          })

    it 'renders show view' do
      allow(Event).to receive(:find).and_return(event)
      get :show, params: { id: event.id }
      expect(response).to render_template('show')
    end
  end
end
