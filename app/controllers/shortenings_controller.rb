class ShorteningsController < ApplicationController
  def new
    @shortening = Shortening.new
  end
  
  def create
    @shortening = Shortening.new(params[:shortening])
    if @shortening.save
      redirect_to @shortening
    else
      flash[:error] = "Error"
      render :action => "new"
    end
  end
  
  def show
    @shortening = Shortening.find(params[:id])
  end
end
