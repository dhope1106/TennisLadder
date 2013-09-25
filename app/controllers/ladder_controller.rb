class LadderController < ApplicationController
  def show
	  if(params[:id].nil?)
  		@user = User.first
  	  else
  		@user  = User.find(params[:id])
  	  end  		
  	  @ladder = User.all
  	  
end
  
  def challenge
  	redirect_to root_url
  end
end
