require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do

  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

  before(:each) do
    person.phone_numbers.create(number: '111-222-333')
    person.phone_numbers.create(number: '444-555-666')
    visit person_path(person)
  end

  it 'shows the phone number' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end

  it 'has a link to add new phone number' do
    expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
  end

  it 'adds a new phone number' do
    page.click_link('Add phone number')
    page.fill_in('Number', with: '555-1111')
    page.click_button('Create Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('555-1111')
  end

  it 'has a link to edit phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_link('edit', href: edit_phone_number_path(phone))
    end
  end

  it 'edits a phone number' do
    phone = person.phone_numbers.first
    old_number = phone.number

    first(:link, 'edit').click
    page.fill_in('Number', with: '999-3333')
    page.click_button('Update Phone number')
    expect(current_path). to eq(person_path(person))
    expect(page).to have_content('999-3333')
    expect(page).to_not have_content(old_number)
  end

  it 'has a link to destroy phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_link('delete', href: phone_number_path(phone))
    end
  end
end

describe 'email address display', type: :feature do
  let(:person) { Person.create(first_name: 'Alice', last_name: 'Smith') }

  before(:each) do
    person.email_addresses.create(address: 'user@example.com')
    person.email_addresses.create(address: 'user2@example.com')
    visit person_path(person)
  end

  it 'has a LI selector' do
    person.email_addresses.each do |email|
      expect(page).to have_selector('li', text: email.address)
    end
  end

  it 'has an add email address link' do
    expect(page).to have_link('Add email address', href: new_email_address_path(person_id: person.id))
  end

  it 'adds a new email address' do
    page.click_link('Add email address')
    page.fill_in('Address', with: 'test@example.com')
    page.click_button('Create Email address')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('test@example.com')
  end


end
