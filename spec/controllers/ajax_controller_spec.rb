# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET counties' do
    it 'renders county' do
      state = create(:state)
      county = create(:county)
      get :counties, params: {state_symbol: 'CA'}
      expect(response).to render_template(nil)
    end
  end
end
