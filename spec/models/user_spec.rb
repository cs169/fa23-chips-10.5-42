# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe 'when .name is called' do
    it 'returns the full name of the user' do
      user = build(:user)
      expect(user.name).to eq('John Doe')
    end
  end

  describe 'when .auth_provider is called' do
    it 'returns the appropriate provider' do
      google_user = build(:user, provider: :google_oauth2)
      github_user = build(:user, provider: :github)

      expect(google_user.auth_provider).to eq('Google')
      expect(github_user.auth_provider).to eq('Github')
    end
  end

  describe 'when .find_google_user is called' do
    it 'returns the correct user with google_oauth2 provider and specific uid' do
      google_user = create(:user, provider: :google_oauth2, uid: '1')
      user = described_class.find_google_user('1')

      expect(user).to eq(google_user)
    end
  end

  describe 'when .find_github_user is called' do
    it 'returns the correct with github provider and specific uid' do
      github_user = create(:user, provider: :github, uid: '2')
      user = described_class.find_github_user('2')

      expect(user).to eq(github_user)
    end
  end
end
