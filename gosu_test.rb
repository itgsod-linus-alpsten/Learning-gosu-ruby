require 'gosu'
require_relative 'player'

class Window < Gosu::Window

  def initialize
    super 800, 600, false
    self.caption = "Gosu Tutorial Game"

    @background_image = Gosu::Image.new(self, 'background_test.png', true)

    @player = Player.new(self)
    @player.warp(100,436)
  end

  def update
    if button_down? Gosu::KbLeft
      @player.move_left
    end
    if button_down? Gosu::KbRight
      @player.move_right
    end
    if button_down? Gosu::KbEscape
      close
    end
    if button_down? Gosu::KbUp
      @player.jump
    end
    @player.gravity
    @player.move
  end

  def draw
    @player.draw
    @background_image.draw(0,0,0)
  end

end

window = Window.new
window.show