Given /^A logged out user$/ do
  visit '/users/sign_out'
end

Given /^A logged in user "([^\/"]*)"$/ do |username|
  @user = User.find_by_username(username) || User.make!(:username => username)

  visit '/users/sign_in'
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
  click_button "Sign in"
end