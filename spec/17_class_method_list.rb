require './spec_helper'


describe Robot do 
  
  describe "#list" do

    before :each do
      Object.send(:remove_const, 'Robot')
      load 'Robot.rb'
      @robot1 = Robot.new
      @robot2 = Robot.new
      @robot3 = Robot.new
    end


    it "Has a method clas with all created robots" do
    
      expect(Robot.list).to eq([@robot1,@robot2,@robot3])
  
    end
  end

end