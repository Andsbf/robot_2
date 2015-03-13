require './spec_helper'

# Since grenades have a range of 2, if the robot has one equipped,
# it can attack an enemy robot that is 2 tiles away instead of just 1 tile away
# That said, it will also discard/unequip the grenade

describe Battery do

  it "Battery can charge robot shield" do
    @robot1 = Robot.new
    @battery = Battery.new
    @robot1.shield = 10
    @battery.recharge_shield(@robot1)
    expect(@robot1.shield).to eq(40)
  end


end

describe Robot do

  describe '#pick_up' do

    context "pick_up battery" do

      before :each do
        @robot1 = Robot.new
        @battery = Battery.new

      end

      it "store the battery" do
        @robot1.shield = 45
        @robot1.pick_up(@battery)
        expect(@robot1.items.last).to eq(@battery)
      end
      it "Shield remains the same" do
        @robot1.pick_up(@battery)
        expect(@robot1.shield).to eq(50)
      end
      it "uses the battery when pick_up, dont append to items" do
        @robot1.shield = 15
        @robot1.pick_up(@battery)
        expect(@robot1.items).not_to include(@battery)
      end

      it "shield is increase when pickup bat and shield is smaller than 20" do
        @robot1.shield = 15
        @robot1.pick_up(@battery)
        expect(@robot1.shield).to eq(45)
      end
    end
  end
end
