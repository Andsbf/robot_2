class Battery < Item

  def initialize
    super("Battery", 25)
  end

  def recharge_shield(robot)
    robot.recharge_shield(30)
  end

end
