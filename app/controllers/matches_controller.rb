class MatchesController < ApplicationController

	before_filter :signed_in_user, only: [:challenge, :destroy]
	before_filter :correct_user, only: [ :destroy]

  def new
    @player1 = User.find(params[:myid])
    @player2 = User.find(params[:id])
  end
  
  def challenge
  	@match = Match.new
  	#@match.player1 = @player1
  	#@match.player2 = @player2
  	@match.player1id = params[:player1]
  	@match.player2id = params[:player2]
  	if @match.save
  		 @match.getmatch(@match.id)
  	     flash[:success] = "Match between "+@match.player1.name+" and "+@match.player2.name+" submitted to "+@match.player2.email
  	     Pony.mail( :to => @match.player2.email,
  	     			:subject => "Match Challenge from: "+@match.player1.name,
  	     			:body => "You have been challenged to a match by "+@match.player1.name+"\nPlease login to David's Tennis Ladder to to accept")
	else
	     flash[:failure] = @match.errors.full_messages
	end
  	redirect_to @match.player1
  end
  
  def accept
  	@match = Match.find(params[:id])
  	@match.accepted = true;
  	@match.save
  	flash[:success] = "Match accepted."
  	redirect_to current_user
  end
  
  def destroy
  puts "this is a a test"
  	@match = Match.find(params[:id])
    user1 = User.find(@match.player1id)
    user2 = User.find(@match.player2id)
  	@match.destroy
  	
	 Pony.mail( :to => user1.email+","+user1.email,
			:subject => "Match Challenge Cancelled",
			:body => "Challenge between "+user1.name+" and "+user2.name+" has been cancelled")
  	
  	flash[:success] = "Match cancelled."
  	redirect_to current_user
  end

	def show
		redirect_to current_user
	end

  private
  	def signed_in_user
  		unless signed_in?
  			store_location
  			redirect_to signin_url, notice: "Please sign in."
  		end
  	end
  	
  	def correct_user
  		@match = Match.find(params[:id])
  		
  		if(!current_user.id == @match.player1id && !current_user.id == @match.player2id)
 	 		redirect_to(user_url) 
 	 	end
  	end

end
