require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
  	get signup_path

  	assert_no_difference "User.count" do
  		post users_path, user: { 	name: "",
	  								email: "user@invalide",
	  								password: "foo",
	  								password_confirmation: "bar" }
  		end

  		assert_template 'users/new'
      assert_select 'div#error_explanation'
      assert_select 'div.alert-danger'
      assert_select 'div#error_explanation li', 4
      assert_select 'div#error_explanation li', /.*name.*blank.*/i
      assert_select 'div#error_explanation li', /.*email.*invalid.*/i
      assert_select 'div#error_explanation li', /.*password.*too short.*/i
      assert_select 'div#error_explanation li', /.*password confirmation.*match.*/i
  	end

  	test "valid signup information" do
  	get signup_path

  	assert_difference "User.count", 1 do
  		post_via_redirect users_path, user: { 	name: "Example User",
				  								email: "user@example.com",
				  								password: "password",
				  								password_confirmation: "password" }
  		end

      assert is_logged_in?
  		assert_template 'users/show'
      assert_not flash.empty?
      assert_select 'div.alert-success'
  	end
end
