class Robot

  attr_accessor :position
  attr_accessor :items
  attr_accessor :health
  attr_accessor :equipped_weapon

  def initialize
    @position = [0, 0]
    @items = []
    @health = 100
  end

  def pick_up(item)
    return false if item.weight + items_weight > 250
    @items << item
    @equipped_weapon = item if item.is_a?(Weapon)
    item.feed(self)  if ( item.kind_of?(BoxOfBolts) && health <= 80 )
    true
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
    @health -= amount
    @health = 0 if @health < 0
  end

  def heal(amount)
    @health += amount
    @health = 100 if @health > 100
  end

  def attack(robot)
    return nil unless reachable?(robot)
    if @equipped_weapon
      @equipped_weapon.hit(robot)
      @equipped_weapon = nil  if @equipped_weapon.kind_of? Grenade
    else
      robot.wound(5)
    end
  end

  def items_weight
    @items.inject(0) {|sum, i| sum += i.weight }
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

end
