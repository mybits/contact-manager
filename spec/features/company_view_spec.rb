require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the company view', type: :feature do

  let(:company) { Company.create(name: 'Chacha') }

  before(:each) do
    company.phone_numbers.create(number: '111-222-333')
    company.phone_numbers.create(number: '444-555-666')
    visit company_path(company)
  end

  it 'shows the phone number' do
    company.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end

  it 'has a link to add new phone number' do
    expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
  end

  it 'adds a new phone number' do
    page.click_link('Add phone number')
    page.fill_in('Number', with: '555-1111')
    page.click_button('Create Phone number')
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content('555-1111')
  end

  it 'has a link to edit phone numbers' do
    company.phone_numbers.each do |phone|
      expect(page).to have_link('edit', href: edit_phone_number_path(phone))
    end
  end

  it 'edits a phone number' do
    phone = company.phone_numbers.first
    old_number = phone.number

    first(:link, 'edit').click
    page.fill_in('Number', with: '999-3333')
    page.click_button('Update Phone number')
    expect(current_path). to eq(company_path(company))
    expect(page).to have_content('999-3333')
    expect(page).to_not have_content(old_number)
  end

  it 'has a link to delete phone numbers' do
    company.phone_numbers.each do |phone|
      expect(page).to have_link('delete', href: phone_number_path(phone))
    end
  end
end
