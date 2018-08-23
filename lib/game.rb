require_relative './market'
require_relative './inventory'
require_relative './climate'
require_relative './day'
require_relative './viewer'

class Game
  def initialize
    @viewer = Viewer.new
    @inventory = Inventory.new
    @climate = Climate.new
    @viewer.welcome(@inventory.money)
    next_day
  end

   def get_weather
     @climate.progress_weather_patterns
   end

   def next_day
    while @inventory.money > 0
      @day = Day.new(@inventory, get_weather)
    end
   end
end

my_game = Game.new