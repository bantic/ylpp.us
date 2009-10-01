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
  
  def mine
    @shortenings = get_hashes_for_user.collect{|hash| Shortening.find_by_hash_key(hash)}
  end
  
  def create
    @shortening = Shortening.new(params[:shortening])
    if !@shortening.save
      flash.now[:error] = true
    else
      save_hash_for_user(@shortening)
      flash.now[:created] = true
    end
  end
  
  def show
    @shortening = Shortening.find_by_hash_key(params[:id])
  end
end
