require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "root should route to home" do
    get root_path
    assert :sucess
  end

end
