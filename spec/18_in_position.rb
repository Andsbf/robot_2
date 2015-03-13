require './spec_helper'

describe Robot do 
  
  describe "#in_position" do
    before :each do
      Object.send(:remove_const, 'Robot')
      load 'Robot.rb'
      robot1 = Robot.new.move_left
      robot2 = Robot.new.move_up
      robot3 = Robot.new.move_down
      robot4 = Robot.new.move_right
      robot5 = Robot.new

    end

    it "return an array with position of all robot instances" do
      

      expect(Robot.in_position).to eq([[-1,0],[0,1],[0,-1],[1,0],[0,0]])
      
    end
  end

end