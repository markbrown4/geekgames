class Admin::PagesController < Admin::ApplicationController
  
  expose(:pages) { Page.all }
  
end