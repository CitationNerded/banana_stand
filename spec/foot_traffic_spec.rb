require 'foot_traffic'

describe FootTraffic do
  before do
    @foot_traffic = FootTraffic.new
  end

  describe "Given I have a new group of walkers" do
    it "should return the original initialized value" do
      expect(@foot_traffic.walkers).to equal 10
    end
  end

  describe "Given I am estimating how many people will visit today" do
    it "should return a value based on the stubbed weather." do
      @foot_traffic.walker_forecast(10)
      expect(@foot_traffic.walkers).to equal 100
    end
  end

end