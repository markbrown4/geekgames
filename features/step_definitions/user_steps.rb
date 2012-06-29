Then /^I should be signed in$/ do
  page.should have_css('#profile.drop-down')
end