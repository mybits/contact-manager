require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the application', type: :feature do

  context 'when logged out' do
    before(:each) do
      visit root_path
    end

    it 'has a login link' do
      expect(page).to have_link('Login', href: login_path)
    end

    it 'does not link to logout' do
      expect(page).to_not have_link('Logout', href: logout_path)
    end
  end

  context 'when logged in' do
    before(:each) do
      visit root_path
    end

    it 'has a logout link' do
      expect(page).to have_link('Logout', href: logout_path)
    end
  end
end
