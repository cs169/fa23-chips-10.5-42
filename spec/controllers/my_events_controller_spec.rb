# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  describe 'GET new' do
    it 'redirects to login' do 
      get :new, params:{ id: 1}
      expect(response).to redirect_to(login_path)
    end
  end

end
