# Helper functions for integration tests using capybara
module UserMacros
  def register(user)
    visit root_path
    click_link('Sign Up')
    fill_in 'Handle', with: user.handle
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
  end


end
