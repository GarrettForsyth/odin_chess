require 'rails_helper'

describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it 'has a valid factory' do
    expect(user.valid?).to eq(true)
  end

  it 'is invalid without a handle ' do
    user.handle = ''
    expect(user.valid?).to eq(false)
  end

  it 'is invalid with a blank handle' do
    user.handle = '         '
    expect(user.valid?).to eq(false)
  end

  it 'is invalid with a handle longer than 30 characters' do
    user.handle = 'a' * 31
    expect(user.valid?).to eq(false)
  end

  it 'is invalid without an email' do
    user.email = ''
    expect(user.valid?).to eq(false)
  end

  it 'is invalid with a blank email address' do
    user.email = '      '
    expect(user.valid?).to eq(false)
  end

  it 'is invalid with an email longer than 256 charcters' do
    user.email = 'a' * 257 + '@example.com'
    expect(user.valid?).to eq(false)
  end

  it 'accepts valid email addresses' do
    valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user.valid?).to eq true
    end
  end

  it 'rejects invalid emails' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@baz_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user.valid?).to eq(false)
    end
  end

  it 'is invalid if it is not a unique email address' do
    user.save
    dup_user = FactoryBot.build(:user)
    dup_user.email = user.email.upcase
    expect(dup_user.valid?).to eq(false)
  end

  # note: devise will auto downcase the email key since
  # it is used as the authentication key see config/initializers/devise.rb
  it 'saves its email addresses in lowercase' do
    mixed_case_email = 'fOoBar@ExaMpLe.COm'
    user.email = mixed_case_email
    user.save
    expect(user.email).to eq(mixed_case_email.downcase)
  end

  it 'invalid with a blank password' do
    user.password = ' ' * 6
    expect(user.valid?).to eq(false)
  end

  it 'is invalid with a password under the minimum length' do
    user.password = 'a' * 5
    expect(user.valid?).to eq(false)
  end
end
