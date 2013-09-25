require 'spec_helper'

describe Match do

	let(:user) { FactoryGirl.create(:user)}
	before do
		@match = Match.new(player1id: user.id, player2id: user.id, date: 'Today', score: '6-0 6-0')
	end
	
	subject {@match}
	
	it {should respond_to(:player1id)}
	it {should respond_to(:player2id)}
	it {should respond_to(:date)}
	it {should respond_to(:score)}
	
	it {should be_valid}
	
	describe "when player1id is not present" do
		before { @match.player1id = nil}
		it {should_not be_valid}
	end

	describe "when player2id is not present" do
		before { @match.player2id = nil}
		it {should_not be_valid}
	end

end
