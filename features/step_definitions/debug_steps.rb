Then /^pause$/ do
  print "Press Return to continue"
  STDIN.getc
end

When /^I wait$/ do
  sleep 10
end

When /^I wait a second$/ do
  sleep 1
end

When /^log "([^"]*)"$/ do | text |
  Rails.logger.info("\n\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  #{text}  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
end

Then /^show$/ do
  save_and_open_page
end

Then /^debug$/ do
  debugger
  0
end