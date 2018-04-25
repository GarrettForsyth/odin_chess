require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  it 'emails the user when requesting password reset' do
    user = FactoryBot.create(:user)
    visit root_path
    click_link 'Login'
    click_link 'Forgot your password?'
    fill_in 'Email', with: user.email
    click_button 'reset password'

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('You will receive an email')
    expect(last_email.to_s).to include(user.email)
  end

  it 'does not email an invalid user when requesting password reset' do
    visit new_user_session_path
    click_link 'password'
    fill_in 'Email', with: 'invalid@email.com'
    click_button 'reset password'

    expect(current_path).to eq(user_password_path)
    expect(last_email).to be_nil
  end
end
