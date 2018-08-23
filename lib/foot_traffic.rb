class FootTraffic
  attr_reader :walkers

  def initialize
    @walkers = 10
  end

  def walker_forecast(weather)
    @walkers = 10 * weather
  end
end