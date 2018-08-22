require 'climate'

describe Climate do
  before do
    @climate = Climate.new
  end

  describe "Given I have a new climate" do
    it "should default to a standard value" do
      expect(@climate.weather).to equal 25
    end
  end

  describe "Given weather patterns have progressed" do
    it "should return a value different from the base weather pattern" do
      @climate.progress_weather_patterns(2)
      expect(@climate.weather).to equal 27
    end
  end
end