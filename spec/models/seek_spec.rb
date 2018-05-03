require 'rails_helper'

RSpec.describe Seek, type: :model do
  before(:each) do
    @user = FactoryBot.create(:confirmed_user)
  end

  it 'has a valid factory' do
    expect(FactoryBot.build(:seek, user: @user)).to be_valid
  end

  it 'is invalid with a nil' do
    expect(FactoryBot.build(:seek, user: @user, timecontrol: nil)).to_not be_valid
  end

  it 'is invalid with a blank timecontrol' do
    expect(FactoryBot.build(:seek, user: @user, timecontrol: '')).to_not be_valid
  end

  it 'is invalid with a negative timecontrol' do
    expect(FactoryBot.build(:seek, user: @user, timecontrol: -1)).to_not be_valid
  end

  it 'is invalid with a non-numeric timecontrol' do
    expect(FactoryBot.build(:seek, user: @user, timecontrol: 'abc')).to_not be_valid
  end

  it 'is invalid without a user' do
    expect(FactoryBot.build(:seek, user: nil)).to_not be_valid
  end

  it 'is invalid without a a unconfirmed user' do
    @user.confirmed_at = nil
    expect(FactoryBot.build(:seek, user: @user)).to_not be_valid
  end

  it 'is invalid without a seeklist' do
    expect(FactoryBot.build(:seek, user: @user, seeklist: nil)).to_not be_valid
  end
end
