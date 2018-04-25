require 'rails_helper'

describe 'layouts/_global_nav.html.erb' do
  it 'contains links' do
    render
    expect(rendered).to have_xpath("//a[@href='#{root_path}']",
                                   text: 'Odin Chess',
                                   count: 1)
    expect(rendered).to have_xpath("//a[@href='#{new_user_session_path}']",
                                   text: 'Login',
                                   count: '1')
    expect(rendered).to have_xpath("//a[@href='#{new_user_registration_path}']",
                                   text: 'Sign Up',
                                   count: '1')
  end
end
