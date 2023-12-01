# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'GET login' do
    it 'render login template' do
      get :login
      expect(response).to render_template('login')
    end

    it 'redirects to user profile path' do
      session[:current_user_id] = 1
      get :login
      expect(response).to redirect_to(user_profile_path)
    end
  end

  describe 'GET logout' do
    it 'redirect to root path' do
      get :logout
      expect(response).to redirect_to(root_path)
    end
  end
end
