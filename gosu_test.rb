require 'gosu'
require 'csv'
require_relative 'player'
require_relative 'block'

class Window < Gosu::Window

  def initialize
    super 800, 600, false
    self.caption = "Gosu Test Game"

    @background_image = Gosu::Image.new(self, 'background_test.png', true)

    @player = Player.new(self,'8_bit_mario.png')
    @player_img = @player.instance_variable_get(:@image)
    @player.warp(300,386)
    @player_x = @player.get_var("x")
    @player_y = @player.get_var("y")
    @player_width = @player.get_var("image").width
    @player_height = @player.get_var("image").height

    @blocks = []
    block_co = CSV.read('block_coordinates.csv')
    block_co.each do |co|
      co[0] = co.first.to_i
      co[1] = co.last.to_i
      @blocks << Block.new(self,co.first,co.last)
    end
    #block_co.to_h

    @on_mouse = Gosu::Image.new(self,'block.png',false)
  end

  def update
    if button_down? Gosu::KbLeft
      p_move_l = true
      @blocks.each do |block|
        if block.r_edge(@player.instance_variable_get(:@x))== false and block.y(@player.instance_variable_get(:@y)+66,@player.instance_variable_get(:@y)+2)== false #if no space between player and block and player is not abover or below block
          p_move_l = false
        end
      end
      if p_move_l
        @player.move_left
      end
    end
    if button_down? Gosu::KbRight
      p_move_r = true
      @blocks.each do |block|
        if block.l_edge(@player.instance_variable_get(:@x)+48)== false and block.y(@player.instance_variable_get(:@y)+74,@player.instance_variable_get(:@y)+10)== false
          p_move_r = false
        end
      end
      if p_move_r
        @player.move_right
      end
    end
    if button_down? Gosu::KbEscape
      close
    end
    if @player.instance_variable_get(:@x)/25 < @blocks.length
      @player.gravity(@blocks[@player.instance_variable_get(:@x)/25].instance_variable_get(:@y))
      unless @blocks[@player.instance_variable_get(:@x)/25].t_edge(@player.instance_variable_get(:@y)+65)
        @player.on_block(@blocks[@player.instance_variable_get(:@x)/25].instance_variable_get(:@y))
        #@player.stop
      end
    else
      @player.gravity
    end
    if button_down? Gosu::KbUp
      @player.jump
    end
    @player.move
  end

  def draw
    @player.draw
    @background_image.draw(0,0,0)
    @blocks.each do |block|
      block.draw
    end
    @on_mouse.draw(self.mouse_x,self.mouse_y,1)
  end

end

#class Test
#  def initialize(window)
#    @image = Gosu::Image.new(window,'block.png',false)
#  end
#  def draw(x,y)
#    @image.draw(x,y,1)
#  end
#end

window = Window.new
window.show