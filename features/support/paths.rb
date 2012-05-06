module NavigationHelpers

  def path_to(page_name)
    case page_name

    when /home/
      '/'

    when /leaderboard/
      leaderboard_path

    when /prizes/
      prizes_path

    when /profile/
      profile_path

    when /games/
      games_path

    when /the (.*) page/
      page_path($1)

    # when /^the group page for "(.*)"$/i
    #   group = Group.find_by_name($1)
    #   group_path(group)

    end
  end
  
end

World(NavigationHelpers)
