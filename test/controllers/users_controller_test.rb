require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # Gives access to Devise helpers in tests
  include Devise::Test::IntegrationHelpers

  # Mimic the router behavior of setting the Devise scope through the env.
  # @request.env['devise.mapping'] = Devise.mappings[:user]

  # test "the truth" do
  #   assert true
  # end
end
