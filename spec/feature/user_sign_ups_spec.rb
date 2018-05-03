require 'rails_helper'

feature 'UserSignUps', type: :feature do
  scenario 'a user signs up to the site' do
    user = FactoryBot.build(:user)
    register(user)

    expect(current_path).to eq(root_path)
    expect(page).to have_content(
      'A message with a confirmation link has been sent ' \
      'to your email address. Please follow the link to ' \
      'activate your account.'
    )
    expect(last_email.to_s).to include(user.email)
  end

  scenario 'signing up with a taken email' do
    user = FactoryBot.create(:confirmed_user)
    reset_emails

    bad_user = FactoryBot.build(:user, email: user.email)
    register(bad_user)

    expect(current_path).to eq(new_user_registration_path)
    expect(page).to have_content('Email has already been taken')
    expect(last_email).to be_nil
  end

  scenario 'signing up with a taken handle' do
    user = FactoryBot.create(:confirmed_user)
    reset_emails

    bad_user = FactoryBot.build(:user, handle: user.handle)
    register(bad_user)

    expect(current_path).to eq(new_user_registration_path)
    expect(page).to have_content('Handle is already in use')
    expect(last_email).to be_nil
  end

  scenario 'user registers with invalid handle' do
    bad_user = FactoryBot.build(:user, handle: '<bad>')
    register(bad_user)

    expect(current_path).to eq(new_user_registration_path)
    expect(page).to have_content('Handle can only contain numbers and letters')
    expect(last_email).to be_nil
  end

  scenario 'user registers with invalid email' do
    bad_user = FactoryBot.build(:user, email: '<bad>')
    register(bad_user)

    expect(current_path).to eq(new_user_registration_path)
    expect(page).to have_content('Email is invalid')
    expect(last_email).to be_nil
  end

  scenario 'user registers with invalid password' do
    bad_user = FactoryBot.build(:user, password: 'short')
    register(bad_user)

    expect(current_path).to eq(new_user_registration_path)
    expect(page).to have_content('Password is too short')
    expect(last_email).to be_nil
  end

  scenario 'user registers with different confirmation pass' do
    bad_user = FactoryBot.build(:user)
    visit root_path
    click_link('Sign Up')
    fill_in 'user[handle]', with: bad_user.handle
    fill_in 'user[email]', with: bad_user.email
    fill_in 'user[password]', with: bad_user.password
    fill_in 'user[password_confirmation]', with: 'bad'
    click_button 'Sign up'

    expect(current_path).to eq(new_user_registration_path)
    expect(page).to have_content('Password confirmation doesn\'t match Password')
    expect(last_email).to be_nil
  end
end
