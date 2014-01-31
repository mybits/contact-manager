require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'phone numbers display', type: :feature do

  let(:company) { Fabricate(:company) }
  let(:user) { company.user }

  before(:each) do
    company.phone_numbers.create(number: '111-222-333')
    company.phone_numbers.create(number: '444-555-666')
    login_as(user)
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

describe 'email addresses display', type: :feature do

  let(:company) { Fabricate(:company) }
  let(:user) { company.user }

  before(:each) do
    company.email_addresses.create(address: 'test01@example.com')
    company.email_addresses.create(address: 'test02@example.com')
    login_as(user)
    visit company_path(company)
  end

  it 'shows the email address' do
    company.email_addresses.each do |email|
      expect(page).to have_content(email.address)
    end
  end

  it 'has a link to add new email address' do
    expect(page).to have_link('Add email address', href: new_email_address_path(contact_id: company,
      contact_type: 'Company'))
  end

  it 'adds a new email address' do
    page.click_link('Add email address')
    page.fill_in('Address', with: 'test@example.com')
    page.click_button('Create Email address')
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content('test@example.com')
  end

  it 'has a link to edit email address' do
    company.email_addresses.each do |email|
      expect(page).to have_link('edit', href: edit_email_address_path(email))
    end
  end

  it 'edits email address' do
    email = company.email_addresses.first
    old_email = email.address

    first(:link, 'edit').click
    page.fill_in('Address', with: 'updated@example.com')
    page.click_button('Update Email address')
    expect(current_path).to eq(company_path(company))
    expect(page).to have_content('updated@example.com')
    expect(page).to_not have_content(old_email)
  end

  it 'has a link to delete email address' do
    company.email_addresses.each do |email|
      expect(page).to have_link('delete', href: email_address_path(email))
    end
  end

end
