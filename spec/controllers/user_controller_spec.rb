# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe 'GET profile' do
    before do
      user = User.create({
                           provider:   1,
                           uid:        'id',
                           email:      'fake@gmail.com',
                           first_name: 'first',
                           last_name:  'last',
                           created_at: DateTime.new(2001, 2, 1),
                           updated_at: DateTime.new(2002, 9, 1)
                         })
      session[:current_user_id] = user.id
      get :profile
    end

    it 'renders the profile template' do
      expect(response).to render_template('profile')
    end
  end
end
