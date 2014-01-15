require 'spec_helper'

describe Company do
  let(:company) { Fabricate(:company) }

  it 'is valid' do
    expect(company).to be_valid
  end

  it 'is invalid without a name' do
    company.name = nil
    expect(company).to_not be_valid
  end

  it 'has an array of phone numbers' do
    expect(company.phone_numbers).to eq([])
  end

  it "responds with its phone numbers after they're created" do
    phone_number = company.phone_numbers.create(number: '111-222')
    expect(phone_number.number).to eq('111-222')
  end

  it "responds with its email addresses after they're created" do
    email_address = company.email_addresses.create(address: 'test@test.com')
    expect(email_address.address).to eq('test@test.com')
  end

  it 'convert to a string with name' do
    expect(company.to_s).to eq "Chacha"
  end

end
