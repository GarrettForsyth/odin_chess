require 'rails_helper'

describe 'layouts/application' do
  it 'renders the global nav' do
    render
    expect(rendered).to render_template(partial: '_global_nav')
  end
end
