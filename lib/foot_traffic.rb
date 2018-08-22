require_relative './climate'

class FootTraffic
  include Viewer

  attr_accessor :walkers

  def initialize
  end

  def walker_forecast(weather)
    @walkers = 10  unless @walkers != nil
    @walkers *= weather
  end
end