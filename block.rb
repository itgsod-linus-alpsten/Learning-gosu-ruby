class Block

  def initialize(window, x, y)
    @image = Gosu::Image.new(window, 'block.png', false)
    @x = x * 25
    @y = y * 25
    @x_edge = @x + @image.width
    @y_edge = @y + @image.height
  end

  def l_edge(right_edge)
    right_edge < @x
  end

  def r_edge(left_edge)
    left_edge > @x_edge
  end

  def t_edge(bottom_edge) #returns true if player is over block
    bottom_edge > @y
  end

  def b_edge(top_edge) #returns true if player is under block
    top_edge < @y_edge
  end

  def over_block?(bottom_edge) #returns true if player is over block
    bottom_edge > @y
  end

  def under_block?(top_edge) #returns true if player is under block
    top_edge < @y_edge
  end

  def x(x0, x1)
    x0 > @x_edge or x1 < @x
  end

  def in_block?(x0,x1,y0,y1) #returns true if player is inside block
    @x_edge < x0 and x1 > @x and @y_edge < y0 and y1 > @y
  end

  def y(y0, y1)
    y0>@y_edge or y1<@y
  end

  def get_y
    @y
  end

  def get_x
    @x
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end