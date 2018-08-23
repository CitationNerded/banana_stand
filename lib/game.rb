require 'byebug'
require_relative './market'
require_relative './inventory'
require_relative './climate'
require_relative './day'
require_relative './foot_traffic'
require_relative './viewer'

class Game
  def initialize
    @viewer = Viewer.new
    @inventory = Inventory.new
    @climate = Climate.new
    @foot_traffic = FootTraffic.new
    @market = Market.new
    @viewer.welcome(@inventory.money)
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

   def next_day
    while @inventory.money > 0
      @day = Day.new(@inventory, weather.progress_weather_patterns, foot_traffic.walker_forecast(weather.weather), market, viewer)
    end
   end
end

my_game = Game.new