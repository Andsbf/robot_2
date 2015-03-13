require './spec_helper'

describe Robot do 
  
  describe "#scan" do

    before :each do
      Object.send(:remove_const, 'Robot')
      load 'Robot.rb'
    end

    it "return an array with all surrond robots" do  
      robot1 = Robot.new
      robot1.move_left
      robot1.move_left
      robot2 = Robot.new
      robot2.move_up
      robot3 =  Robot.new
      robot4 =   Robot.new
      robot4.move_down
      robot5 = Robot.new
      robot5.move_right
      robot5.move_right
      robot = Robot.new
      expect(robot.scan).to include(robot2, robot3,robot4)
       expect(robot.scan).not_to include(robot1, robot5)
    end
  end

end