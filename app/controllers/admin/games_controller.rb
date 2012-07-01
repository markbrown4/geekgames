class Admin::GamesController < Admin::ApplicationController

  expose(:games) { Game.all }
  expose(:game)

  def update
    if game.save
      flash[:success] = "Game updated"
      redirect_to edit_admin_game_path(game)
    else
      render :edit
    end
  end
  
end