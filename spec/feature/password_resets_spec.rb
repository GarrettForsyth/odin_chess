require 'rails_helper'

feature "Password resets", type: :feature do
  before :each do
    @user = FactoryBot.create(:confirmed_user)
    reset_emails
  end

  scenario 'a confirmed user resets their password' do
    visit root_path
    click_link 'Login'
    click_link 'Forgot your password?'
    fill_in 'Email', with: @user.email
    click_button 'reset password'

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('You will receive an email')
    expect(last_email.to_s).to include(@user.email)
  end

  scenario 'a user enters an unrecognized email' do
    visit root_path
    click_link 'Login'
    click_link 'Forgot your password?'
    fill_in 'Email', with: 'invalid@email.com'
    click_button 'reset password'

    expect(current_path).to eq(user_password_path)
    expect(last_email).to be_nil
  end
end
