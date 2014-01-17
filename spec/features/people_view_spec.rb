require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'


describe 'people view', type: :feature do

  context 'when logged in' do
    let(:user) { Fabricate(:user) }

    it 'displays people associated with the user' do
      person_1 = Fabricate(:person)
      person_1.user = user
      person_1.save
      visit(people_path)
      expect(page).to have_text(person_1.to_s)
    end

    it 'does not display people associated with another user' do
      user_2 = Fabricate(:user)
      person_2 = Fabricate(:person)
      person_2.user = user_2
      person_2.save
      visit(people_path)
      expect(page).to_not have_text(person_2.to_s)
    end
  end
end
