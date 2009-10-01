class ShorteningsController < ApplicationController
  def new
    @shortening = Shortening.new
  end
  
  def index
    redirect_to :action => "new"
  end
  
  def admin
    @shortenings = Shortening.all
  end
  
  def create
    @shortening = Shortening.new(params[:shortening])
    if !@shortening.save
      flash.now[:error] = true
    else
      update_shortenings_cookie!(@shortening)
      flash.now[:created] = true
    end
  end
  
  def show
    @shortening = Shortening.find_by_hash_key(params[:id])
  end
  
  private
  def update_shortenings_cookie!(shortening)
    shortenings = (cookies['shortenings'] || "").split(",")
    shortenings.unshift(shortening.hash_key)
    cookies['shortenings'] = shortenings.join(",")
  end
end
