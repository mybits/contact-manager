require 'spec_helper'

describe Company do
  let(:company) { Company.create(name: 'Chacha') }

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


end
