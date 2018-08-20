require_relative './market'
require_relative './inventory'
require_relative './user_input'

class Game
  include Viewer
  attr_accessor :market, :inventory, :viewer, :get_input

  def initialize
      welcome
      price_of_split = get_input.to_i
      @inventory = Inventory.new(price_of_split)
      @market = Market.new
      shopping
  end

  def get_input
    gets.chomp.downcase
    #this method should contain some validations. If only numbers are input into the string then convert the string to an array, otherwise leave it as is.
  end

  def shopping
    market_prices
    buy_stock
    make_product
  end

  def market_prices
    @market.market_conditions
    market_price_message
  end

  def buy_stock
    while @inventory.money > 0
      supplies_prompt
      product = get_input
      if (product == "icecream") || (product == "banana")
        buy_supplies(product)
        quantity = get_input.to_i
        @inventory.buy_product(quantity, product)

      elsif product == "stop"
        return
      else
        input_unclear
      end
    end
  end

  def make_product
    production_prompt
    produce_quantity = get_input.to_i
    @inventory.make_split(produce_quantity)
  end
end


my_game = Game.new