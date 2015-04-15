class Player
  def initialize(window)
    @image = Gosu::Image.new(window, '8_bit_mario.png', false)
    @x = 0
    @y = 0
    @vel_x = 0.0
    @vel_y = 0.0
    @jump = true
  end

  def warp(x,y)
    @x, @y = x, y
  end

  def move_left
    @vel_x -= 0.5
  end

  def move_right
    @vel_x += 0.5
  end

  def move
    @x += @vel_x
    @x %= 800
    @y -= @vel_y

    @vel_x *= 0.9
  end

  def gravity
    if @y > 436
      @y = 436
      @vel_y = 0.0
      @jump = true
    elsif @y < 436
      @vel_y -= 0.5
    end
  end

  def jump
    if @jump == true
      @vel_y = 10.0
      @jump = false
    end
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end