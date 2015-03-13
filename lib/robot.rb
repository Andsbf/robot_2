class Robot

  attr_accessor :position, :shield
  attr_accessor :items
  attr_accessor :health
  attr_accessor :equipped_weapon

  @@list_of_robots =[]

  def initialize
    @position = [0, 0]
    @items = []
    @health = 100
    @shield = 50
    @@list_of_robots << self
  end

  def pick_up(item)

    return false if item.weight + items_weight > 250
    self.equipped_weapon = item if item.is_a?(Weapon)
    self.items << item
    if ( item.kind_of?(BoxOfBolts) && health <= 80 )
      item.feed(self)  
      self.items.pop
    end

    if ( item.kind_of?(Battery) && shield <= 20 ) 
      item.recharge_shield(self)  
      self.items.pop
    end
    true
  end

  def recharge_shield(amount)
    self.shield += amount
    self.shield = 50 if shield > 50
    
  end

  def reachable?(enemy)
    distance = enemy.position.map.with_index{ |m,i| m - self.position[i].to_i }
  
    if self.equipped_weapon.kind_of? Grenade
      (distance[0].abs <= 2 && distance[1].abs <= 2)
    else
      (distance[0].abs < 2 && distance[1].abs < 2)
    end
    
  end

  def wound(amount)
     
    if shield > 0
      self.shield -= amount
      if shield < 0
        self.health -= shield.abs
        self.shield = 0
      end
    else
      self.health -= amount
      self.health = 0 if @health < 0
    end
  end

  def heal(amount)
    self.health += amount
    self.health = 100 if @health > 100
  end

  def attack(robot)
    return nil unless reachable?(robot)
    if equipped_weapon
      equipped_weapon.hit(robot)
      self.equipped_weapon = nil  if equipped_weapon.kind_of? Grenade
    else
      robot.wound(5)
    end
  end

  def items_weight
    items.inject(0) {|sum, i| sum += i.weight }
  end

  def move_left
    self.position[0] -= 1
  end

  def move_right
    self.position[0] += 1
  end

  def move_up
    self.position[1] += 1
  end

  def move_down
    self.position[1] -= 1
  end

  def self.list
    @@list_of_robots
  end

  def self.in_position
    Robot.list.collect{|x| x.position}
  end

  def scan
    # binding.pry
     all_robots_positions = Robot.list.dup
     all_robots_positions.delete(self)
     
    all_robots_positions.select! do |robot|
      # binding.pry
      ( (self.position[0] - robot.position[0]).abs <= 1 ) && ( (self.position[1] - robot.position[1]).abs <=1)
    end
  end
end
