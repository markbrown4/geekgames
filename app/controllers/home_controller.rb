class HomeController < ApplicationController
  
  def index
    @page = Page.find_by_slug('home')
  end
  
end
