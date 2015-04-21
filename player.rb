class Player

  def initialize(window,img)
    @image = Gosu::Image.new(window, img, false)
    @x = 100
    @y = 100
    @vel_x = 0.0
    @vel_y = 0.0
    @jump = true
    @window = window
  end

  def x
    @x
  end

  def y
    @y
  end

  def width
    @image.width
  end

  def height
    @image.height
  end

  def get_var(var)
    self.instance_variable_get(("@" + var).intern)
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
    @x %= @window.width
    @y -= @vel_y

    @vel_x *= 0.9
  end

  def gravity(block)
    @vel_y -= 0.5
    if block.class == Block
      floor = block.get_y
    else
      floor = 500
    end
    if @y + @image.height >= floor
      @y = floor - @image.height
      @vel_y = 0.0
      @jump = true
    end
  end

  def on_block(y)
    @y = y - @image.height
  end

  def jump
    if @jump == true
      @vel_y = 10.0
      @jump = false
    end
  end

  def stop
    @vel_y = 0
    @vel_x = 0
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end