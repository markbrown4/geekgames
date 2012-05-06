module HtmlSelectorsHelpers
  # Ref http://bjeanes.com/2010/09/19/selector-free-cucumber-scenarios

  def selector_for(locator)
    case locator
    when '/content/'
      "#content"
    when /the header/
      '#header'
    when /^"(.+)"$/
      $1
    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)