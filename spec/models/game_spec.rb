require 'rails_helper'

RSpec.describe Game, type: :model do
  before(:each) do
    @white = FactoryBot.create(:confirmed_user)
    @black = FactoryBot.create(:confirmed_user)
  end

  it 'has a valid factory' do
    expect(FactoryBot.build(:game,
                            white_user: @white,
                            black_user: @black))
      .to be_valid
  end

  it 'is invalid with a nil' do
    expect(FactoryBot.build(:game,
                            white_user: nil,
                            black_user: @black)).to_not be_valid
    expect(FactoryBot.build(:game,
                            white_user: @white,
                            black_user: nil)).to_not be_valid
    expect(FactoryBot.build(:game,
                            white_user: nil,
                            black_user: nil)).to_not be_valid
  end

  it 'is invalid with a blank timecontrol' do
    expect(FactoryBot.build(:game,
                            white_user: @white,
                            black_user: @black,
                            timecontrol: '')).to_not be_valid
  end

  it 'is invalid with a negative timecontrol' do
    expect(FactoryBot.build(:game,
                            white_user: @white,
                            black_user: @black,
                            timecontrol: '-1')).to_not be_valid
  end

  it 'is invalid with a non-numeric timecontrol' do
    expect(FactoryBot.build(:game,
                            white_user: @white,
                            black_user: @black,
                            timecontrol: 'abc')).to_not be_valid
  end

  it 'is invalid when white is unconfirmed' do
    @white.confirmed_at = nil
    expect(FactoryBot.build(:game,
                            white_user: @white,
                            black_user: @black)).to_not be_valid
  end

  it 'is invalid when black is unconfirmed' do
    @black.confirmed_at = nil
    expect(FactoryBot.build(:game,
                            white_user: @white,
                            black_user: @black)).to_not be_valid
  end

  describe 'move_to_string' do
    it 'converts a legal move to a strng' do
      move =  { from: 'e2', to: 'e4' }
      expect(Game.move_to_string(move)).to eq('e2-e4')
    end
    
    xit 'rejects illegal moves' do
    end

    xit 'rejects ill-formed moves' do
    end
  end


end
