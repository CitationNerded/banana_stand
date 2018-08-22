require_relative './market'
require_relative './inventory'
require_relative './climate'
require_relative './foot_traffic'
require_relative './day'

class Game
  include Viewer
  attr_accessor :market, :inventory, :viewer, :get_input, :get_weather
  def initialize
    @inventory = Inventory.new
    @climate = Climate.new
    welcome
    next_day
  end

   def get_weather
     @climate.progress_weather_patterns
   end

   def next_day
      @day = Day.new(@inventory, get_weather)
   end
end

my_game = Game.new