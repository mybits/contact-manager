require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user) }

  it 'has associated people' do
    expect(user.people).to be_instance_of(ActiveRecord::Associations::CollectionProxy::ActiveRecord_Associations_CollectionProxy_Person)
  end

  it 'builds associated people' do
    person_1 = Fabricate(:person)
    person_2 = Fabricate(:person)
    [person_1, person_2].each do |person|
      expect(user.people).to_not include(person)
      user.people << person
      expect(user.people).to include(person)
    end
  end
end
