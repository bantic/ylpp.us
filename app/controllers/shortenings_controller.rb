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
    if @shortening.save
      redirect_to shortening_info_url(@shortening)
    else
      flash[:error] = "Error"
      render :action => "new"
    end
  end
  
  def show
    @shortening = Shortening.find_by_hash_key(params[:id])
  end
end
