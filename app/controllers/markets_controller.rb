class MarketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, :except => :notlogged
  def index

  end



  def create
    @market = Market.create!(market_params)
    redirect_to user_markets_path
  end

  def set_user
    @user = current_user
  end

  def movie_params
    params.require(:market).permit(:username, :shift, :be_taken, :taker_username) #no need to add more here
  end

end
