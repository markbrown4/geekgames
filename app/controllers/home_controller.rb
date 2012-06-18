class HomeController < ApplicationController
  
  def index
    @menu = 'home'
    @page = Page.find_by_slug('home')
  end
  
end
