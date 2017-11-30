class MarketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, :except => :notlogged
  def index
    @markets = Market.all

  end

  def new
  end

  def create
    @market = Market.create!(market_params)
    flash[:notice] = "#{@market.shift} was successfully sold."
    redirect_to user_markets_path
  end

  def set_user
    @user = current_user
  end

  def market_params
    params.require(:market).permit(:username, :shift, :be_taken, :taker_username) #no need to add more here
  end

end
