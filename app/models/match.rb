class Match < ActiveRecord::Base
  attr_accessible :date, :player1id, :player2id, :score, :accepted
  validates :player1id, presence: true
  validates :player2id, presence: true
  
  def player1=(player)
    @player1 = player
  	@player1id = player.id
  end
  
  def player2=(player)
  	@player2 = player
  	@player2id = player.id
  end
  
  def getmatch(id)
  	@match = Match.find(id)
  end
  
  def player1
  	#@match = Match.find(params[id])
    if(@match.player1id.nil?)
       User.new
    else
  		User.find(@match.player1id)
  	end
  end
  
  def player2
  	#@match = Match.find(params[:id])
  	if(@match.player2id.nil?)
  		User.new
  	else
	  	User.find(@match.player2id)
	end
  end
  
  def accept
  	#@match = Match.find(params[:id])
  	accepted = true;
  	save
  	flash[:success] = "Match accepted."
  	redirect_to player1
  end
end
