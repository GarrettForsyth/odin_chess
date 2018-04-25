require 'rails_helper'

RSpec.describe 'UserSignUps', type: :request do
  it 'emails the user when creating a new account' do
    user = FactoryBot.build(:user)
    register(user)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
    expect(last_email.to_s).to include(user.email)
  end

  it 'does not email an invalid registration during sign up' do
    user = FactoryBot.build(:user)
    bad_user = FactoryBot.build(:user)
    bad_user.email = user.email

    register(user)
    reset_emails
    register(bad_user)

    expect(current_path).to eq(new_user_registration_path)
    expect(page).to have_content('Email has already been taken')
    expect(last_email).to be_nil
  end
end
