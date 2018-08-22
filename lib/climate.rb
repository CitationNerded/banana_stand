class Climate
  attr_reader :weather
  
  def initialize
    @weather = 25
  end

  def progress_weather_patterns
    weather_modifier = rand(-5..5)
    @weather += weather_modifier
  end
end