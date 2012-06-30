class Admin::PrizesController < Admin::ApplicationController

  expose(:deal)
  expose(:prizes) { deal.prizes }
  expose(:prize)
  
  def index
  end
  
  def edit
  end

  def update
    if prize.save
      flash[:success] = "Game updated"
      redirect_to edit_admin_deal_prize_path(deal, prize)
    else
      render :edit
    end
  end
  
  def create
    if prize.save
      flash[:success] = "Prize created"
      redirect_to edit_admin_deal_prize_path(deal, prize)
    else
      render :new
    end
  end
  
end