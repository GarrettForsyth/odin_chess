# Helper functions for integration tests using capybara
module UserMacros
  def register(user)
    visit root_path
    click_link('Sign Up')
    fill_in 'user[handle]', with: user.handle
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
    click_button 'Sign up'
  end

  def login(user)
    visit new_user_session_path
    fill_in 'Login', with: user.handle
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
