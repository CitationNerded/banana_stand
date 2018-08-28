require_relative '../lib/viewer'
require_relative '../lib/input'
require_relative '../lib/foot_traffic'
require_relative '../lib/market'
require_relative '../lib/inventory'
require_relative '../lib/climate'
require_relative '../lib/day'
require_relative '../lib/day_controller'
describe DayController do
  before do
    @inventory = Inventory.new
    @climate = Climate.new
    @foot_traffic = FootTraffic.new
    @market = Market.new
    @day = Day.new(@inventory, @climate, @foot_traffic, @market)
    
    @viewer = Viewer.new
    @input = Input.new

    @day_controller = DayController.new(@day,@viewer,@input)
  end

  describe "given I define a selling price at the start of the day" do
    it "should be correctly assigned to the product selling price" do
      @day_controller.define_selling_price {2}
      byebug
      #test the viewer returns what im after
    end
  end
end