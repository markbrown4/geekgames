class HomeController < ApplicationController
  
  def index
    @page = Page.find_by_slug('home')
  end
  
  def weekend
    @page = Page.find_by_slug('home')
  end
  
  def finished
    @winner = Round.leaders.first.user
  end
  
end
