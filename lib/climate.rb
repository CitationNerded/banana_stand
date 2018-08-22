class Climate
  attr_reader :weather
  
  def initialize
    @weather = 25
  end

  def progress_weather_patterns(weather_modifier)
    @weather += weather_modifier
  end

  private
  def weather_modifier
    rand(-5..5)
  end
end