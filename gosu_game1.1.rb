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
    @blocks_spaces = Array.new(@settings['height']/@settings['block_width'],Array.new(@settings['width']/@settings['block_width']))

    #player ini start
    @player = Player.new(self,'8_bit_mario.png')
    @player.warp(100,286)
    #player ini stop

    #block ini start
    @blocks = []
    @block_coordinates = CSV.read('block_coordinates.csv')
    @block_coordinates.each do |coordinates|
      coordinates[0] = coordinates[0].to_i
      coordinates[1] = coordinates[1].to_i
      @blocks_spaces[coordinates[0]] = @blocks_spaces[coordinates[0]].dup
      @blocks << Block.new(self,coordinates[1],coordinates[0])
      @blocks_spaces[coordinates[0]][1] = @blocks.last
    end
    @blocks_around_player = []
    @blocks_spaces[@player.y/@settings['block_width']-1..(@player.y+@player.get_var('image').height)/@settings['block_width']+1].each do |blocks|
      @blocks_around_player << blocks[@player.x/@settings['block_width']-1..(@player.x+@player.get_var('image').width)/@settings['block_width']+1]
    end
    @blocks_spaces[@player.y/@settings['block_width']..@blocks_spaces.length-1]
    #block ini stop
  end

  def update
    # noinspection RubyResolve
    @player.gravity(@blocks_around_player[-1][1])
    if button_down? Gosu::KbEscape
      close
    end
    if button_down? Gosu::KbLeft
      @player.move_left
    end
    if button_down? Gosu::KbRight
      @player.move_right
    end
    if button_down? Gosu::KbUp
      @player.jump
    end
    @player.move

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