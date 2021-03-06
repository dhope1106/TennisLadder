require 'pony'

class UsersController < ApplicationController

	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: :destroy

  def new
  	@user = User.new
  end
  
  def show
  	@user = User.find(params[:id])
  	
  	@challenges = Array.new
  	@accepted = Array.new
  	@matches = Array.new
  	
  	Match.all.each do |match|
  		if (@user.id==match.player1id || @user.id==match.player2id)
			if	(match.score.nil? or match.score.length==0)
				if(match.accepted==true)
					@accepted << match
				else
					@challenges << match
				end
			else
				@matches << match
			end
  		end
  	end
  end
  
  def destroy
  	User.find(params[:id]).destroy
  	flash[:success] = "User destroyed."
  	redirect_to users_url
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  	
  def challenge
  	redirect_to root_url
  end
  				
  def edit
  end
  
  def index
  	@users = User.paginate(page: params[:page])
  end
  
  def update
  	if @user.update_attributes(params[:user])
  		flash[:success] = "Profile Updated"
  		sign_in @user
  		redirect_to @user
  		Pony.mail({:to=>@user.email,
  			:subject=>'Your DavidsTennisLadder profile was Updated',
  			:body=>'Your DavidsTennisLadder profile was Updated.'})
  	else
  		render 'edit'
  	end
  end
  
  private
  	def signed_in_user
  		unless signed_in?
  			store_location
  			redirect_to signin_url, notice: "Please sign in."
  		end
  	end
  	
  	def correct_user
  		@user = User.find(params[:id])
  		redirect_to(root_url) unless current_user?(@user)
  	end
  	
  	def admin_user
  		redirect_to(users_url) unless current_user.admin?
  	end
  
end
