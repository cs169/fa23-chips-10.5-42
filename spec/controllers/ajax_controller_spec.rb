# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET counties' do
    it 'renders county' do
      /
      state = State.create({  name:         'name',
                              symbol:       'symbol',
                              fips_code:    1,
                              is_territory: true,
                              lat_min:      1.11,
                              lat_max:      2.22,
                              long_min:     3.33,
                              long_max:     4.44,
                              created_at:   DateTime.new(2001, 2, 1),
                              updated_at:   DateTime.new(2002, 9, 1) })
      county = County.create({  name:       'name',
                                state_id:   state.id,
                                fips_code:  1,
                                fips_class: 'fips_class',
                                created_at: DateTime.new(2001, 2, 1),
                                updated_at: DateTime.new(2002, 9, 1) })

      /
      get :counties, params: { state_symbol: 'symbol' }
      expect(response).to render_template(json: [county])
    end
  end
end
