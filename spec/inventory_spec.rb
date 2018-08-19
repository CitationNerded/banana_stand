require 'inventory'

describe Inventory do
  before do
    starting_money = 5
    set_cost_of_banana_split = 10
    @user_inventory = Inventory.new(set_cost_of_banana_split,starting_money)
  end
  
  describe "Given I purchase icecream" do
    it "and I do not define a quantity" do
      expect(@user_inventory.icecream_scoop).to equal 0
      expect(@user_inventory.money).to equal 10
    end
  end
end