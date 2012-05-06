class Admin::UsersController < Admin::ApplicationController
  
  expose(:users) { User.all }
  
end