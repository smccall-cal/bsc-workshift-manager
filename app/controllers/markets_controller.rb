class MarketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, :except => :notlogged
  def index
    @markets = Market.all

  end

  def new
    @user = current_user

  end

  def create
    @market = Market.create!(market_params)
    # @market = @user.markets.create!(market_params)
    flash[:notice] = "Sale for #{@market.shift} was successfully deliverd."
    redirect_to user_markets_path
  end


  def edit
    username = params[:username]
    shift = params[:shift]
    cancel = params[:cancel]
    @markets = Market.where(username: username, shift: shift)
    @markets.each do |market|
      if cancel
        market.update_attributes!(:be_taken => false)
        flash[:notice] = "#{market.username}'s #{market.shift} returns to not sold."

      else
        market.update_attributes!(:be_taken => true)
        flash[:notice] = "#{market.username}'s #{market.shift} was successfully sold."

      end


    end
    redirect_to user_markets_path
  end


  def destroy
    username = params[:username]
    @market = Market.find_by_username(username).destroy
    flash[:notice] = "Sale for #{username}'s #{@market.shift} shift was successfully canceled."
    redirect_to user_markets_path
  end

  def set_user
    @user = current_user
  end

  def market_params
    params.require(:market).permit(:username, :shift, :be_taken, :taker_username) #no need to add more here
  end

end
