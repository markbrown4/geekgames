
Given /^a "([^"]*)" page exists with title "([^"]*)"$/ do |slug, title|
  Page.find_by_slug(slug) || Page.make!(:slug => slug, :title => title)
end
