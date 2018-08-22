class Climate
  include Viewer

  attr_accessor :weather, :progress_weather_patterns

  def initialize
    @weather = 25
  end

  def progress_weather_patterns
    weather_modifier = rand(-5..5)
    @weather += weather_modifier
  end
end