require 'rails_helper'

RSpec.describe Seeklist, type: :model do
  it 'has a valid facotry' do
    expect(FactoryBot.build(:seeklist)).to be_valid
  end

  it 'is invalid if the name is empty' do
    FactoryBot.create(:seeklist, name: 'copycat')
    expect(FactoryBot.build(:seeklist, name: 'copycat')).to_not be_valid
  end

  it 'is invalid with an empty name' do
    expect(FactoryBot.build(:seeklist, name: '')).to_not be_valid
  end
end
