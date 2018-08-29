class DayController
  attr_reader :viewer, :days_survived, :day
  def initialize(model, view, input, days_survived)
    @day = model
    @viewer = view
    @input = input
    @days_survived = days_survived
  end
  
  #private
  def welcome_to_game
    @viewer.welcome(@day.account_balance) if @days_survived.zero?
  end

  
  def define_selling_price
    display_market_rates
    @day.set_product_price(@input.get_input)
  end
  
  def day_progression
    welcome_to_game
    define_selling_price
    select_option
  end

  def select_option
    options_menu
  end

  def options_menu
    selected_option = nil
    while selected_option != 0    
      @viewer.user_options
      selected_option = @input.get_input(7)
      case selected_option #put selected option here.
      when 0
        process_day
      when 1
        buy_product
      when 2
        make_product
      when 3
        define_selling_price
      when 4
        display_weather_report  
      when 5
        display_market_rates      
      when 6
        display_bank_balance       
      when 7
        display_foot_traffic
      end
    end
  end

  def display_weather_report
    @viewer.weather_report(@day.climate)
  end


  def display_market_rates
    @viewer.market_price_message(@day.market.banana_price,@day.market.icecream_price,@day.market.break_even_price)
  end

  def display_bank_balance
    @viewer.bank_balance(@day.inventory.money)
  end

  def display_foot_traffic
    @viewer.walker_report(@day.foot_traffic)
  end

  def buy_product
    @viewer.supplies_message
    @day.stock_to_purchase(@input.get_input(@day.inventory.stock.length))

    @viewer.buy_supplies_message
    @day.quantity_to_purchase(@input.get_input)

    @day.purchase_stock

    @viewer.insufficient_credit if @day.inventory.insufficient_credit
    @viewer.bank_balance(@day.inventory.money)
    @viewer.product_status(@day.inventory.stock[@day.stock_to_buy], @day.stock_to_buy)
  end

  def make_product
    @viewer.product_select_message
    @day.product_to_make(@input.get_input(@day.inventory.sellable_product.length))

    @viewer.product_quantity_message(@day.product)
    @day.quantity_to_make(@input.get_input)

    @day.make_product
    @day.inventory.stock.each{ |value,key| @viewer.product_status(key, value)}

    @viewer.product_status(@day.inventory.sellable_product.values[0], @day.inventory.sellable_product.keys[0])
  end

  def process_day
    @day.establish_buyers
    @day.sell_product
    @viewer.sales_message(@day.inventory.actual_buyers, @day.inventory.potential_buyers, @day.inventory.sellable_product.keys[0])
    @day.establish_profit
    @viewer.end_of_day_report(@day.inventory.money, @day.net_profit)

    @day.destroy_product_surplus

    return @viewer.you_have_failed if @day.loss_condition?
    @viewer.you_have_survived(@day.days_survived)
  end
end