def login_user
  visit '/users/sign_in'
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
  click_button "Sign in"
end

def logout_user
  visit '/users/sign_out'
end

Given /^A logged out user$/ do
  logout_user
end

Given /^A logged in user "([^\/"]*)"$/ do |username|
  @user = User.find_by_username(username) || User.make!(:username => username)
  login_user
end

Then /^I should be signed in$/ do
  page.should have_css('#profile')
end

And /^my email should be filled in$/ do
  step %{the "Email" field should contain "mark@email.com"}
end

