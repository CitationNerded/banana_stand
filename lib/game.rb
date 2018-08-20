class Game
  attr_accessor :market, :inventory, :viewer

  def initialize 
      @inventory = Inventory.new(8, 5)
      @viewer = Viewer.new
      @user_input = UserInput.new
      @market = Market.new
  end
end

my_game = Game.new