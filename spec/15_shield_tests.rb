require './spec_helper'

# Since grenades have a range of 2, if the robot has one equipped,
# it can attack an enemy robot that is 2 tiles away instead of just 1 tile away
# That said, it will also discard/unequip the grenade

describe Robot do

  before :each do 
    @robot = Robot.new
  end

  describe '#wound' do

    context "attack robot that has shield" do

      before :each do
        @robot1 = Robot.new
        @robot2 = Robot.new
      end
      puts RUBY_VERSION
      puts RUBY_PATCHLEVEL
      context "robot attacks another now robot" do

        it "robot with 50 shield is attacked with 05" do
          @robot1.attack(@robot2)
          expect(@robot2.shield).to eq(45)
          
        end

        it "robot with 1 shield is attacked with 05" do
          @robot2.shield = 1
          @robot1.attack(@robot2)
          expect(@robot2.shield).to eq(0)
          expect(@robot2.health).to eq(96)
        end

        it "robot with 2 health is attacked with 05" do
          @robot2.shield = 0
          @robot2.health = 2
          @robot1.attack(@robot2)
          expect(@robot2.shield).to eq(0)
          expect(@robot2.health).to eq(0)
        end


      end

    end
  end
end
