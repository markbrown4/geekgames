class Admin::DealsController < Admin::ApplicationController

  expose(:deals) { Deal.scoped }
  expose(:deal)
  
  def update
    if deal.save
      flash[:success] = "Deal updated"
      redirect_to edit_admin_deal_path(deal)
    else
      render :edit
    end
  end
  
  def create
    if deal.save
      flash[:success] = "Deal created"
      redirect_to admin_deals_path
    else
      render :new
    end
  end
  
  def destroy
    deal.destroy
    flash[:success] = "Deal deleted"
    redirect_to admin_deals_path
  end
  
  def show
    @round = Round.first
    @deal = deal
    render :template => "rounds/win", :layout => 'application'
  end
  
end