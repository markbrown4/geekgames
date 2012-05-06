module HtmlSelectorsHelpers
  # Ref http://bjeanes.com/2010/09/19/selector-free-cucumber-scenarios

  def selector_for(locator)
    case locator
    when '/the content/'
      "#content"
    when /the user drop down/
      '#profile'
    when /todays first/
      '#today .pos-1'
    when /all time first/
      '#all-time .pos-1'
    when /first placed country/
      '#country .pos-1'
    when /second placed country/
      '#country .pos-2'
       
    when /^"(.+)"$/
      $1
    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)