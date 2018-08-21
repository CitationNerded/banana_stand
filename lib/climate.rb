class Climate
  include Viewer

  attr_accessor :weather

  def progress_weather_patterns
    @weather = 25 unless @weather != nil
    weather_modifier = rand(-5..5)
    @weather += weather_modifier
  end
end