require 'rails_helper'

describe 'static_pages/home.html.erb' do
  before do
    render
  end

  it 'should display the title' do
    expect(rendered).to match('Odin Chess')
  end
end
