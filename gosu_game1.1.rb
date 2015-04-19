require 'gosu'
require 'csv'
require 'inifile'
require_relative 'player'
require_relative 'block'

class Window < Gosu::Window

  def initialize(ini)
    @settings = IniFile.load('ini_files/1.1.ini')[ini]
    super @settings['width'], @settings['height'], @settings['fullscreen']
    # noinspection RubyResolve
    self.caption = "Gosu game 1.1"
    @background_image = Gosu::Image.new(self,'background_test.png',true)
    @blocks_spaces = Array.new(width/@settings['block_width'],Array.new(height/@settings['block_width']))

    #player ini start
    @player = Player.new(self,'8_bit_mario.png')
    @player.warp(300,386)
    #player ini stop

    #block ini start
    @blocks = []
    @block_coordinates = CSV.read('block_coordinates.csv')
    @block_coordinates.each do |coordinates|
      coordinates[0] = coordinates[0].to_i
      coordinates[1] = coordinates[1].to_i
      @blocks_spaces[coordinates[0]] = @blocks_spaces[coordinates[0]]
      @blocks << Block.new(self,coordinates[0],coordinates[1])
      @blocks_spaces[coordinates[0]][1] = @blocks.last
    end
    @blocks_around_player = @blocks_spaces[@player.x/@settings['block_width']-1..@player.x/@settings['block_width']+1][@player.y/@settings['block_width']-1..@player.y/@settings['block_width']]
    #block ini stop
  end

  def update
    # noinspection RubyResolve
    if button_down? Gosu::KbEscape
      close
    end

  end

  def draw
    @background_image.draw(0,0,0)
    @blocks.each {|block|block.draw}
    @player.draw
  end

end

# noinspection RubyArgCount
window = Window.new('game')
window.show