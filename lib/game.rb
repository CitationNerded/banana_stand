require 'byebug'
require_relative './market'
require_relative './inventory'
require_relative './climate'
require_relative './day'
require_relative './foot_traffic'
require_relative './viewer'
require_relative './input'
require_relative './day_controller'

class Game
  def initialize
    @viewer = Viewer.new
    @inventory = Inventory.new
    @climate = Climate.new
    @foot_traffic = FootTraffic.new
    @market = Market.new
    @viewer.welcome(@inventory.money)
    @input = Input.new
    next_day
  end

   def weather
     @climate
   end

   def foot_traffic
    @foot_traffic
   end

   def market
    @market
   end

   def viewer
    @viewer
   end

   def input
    @input
   end

   def day
    @day = Day.new(@inventory, weather.progress_weather_patterns, foot_traffic.walker_forecast(weather.weather), market, input)
   end

   def next_day
    while @inventory.money > 0
      day
      
      @day_controller = DayController.new(day, viewer)
      
    end
   end
end

my_game = Game.new