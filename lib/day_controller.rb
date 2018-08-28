class DayController
  attr_reader :viewer
  def initialize(model, view, input)
    @day = model
    @viewer = view
    @input = input

  end
  
  #private
  
  def day_progression
    define_selling_price {@input.get_input}
    select_option
  end
  
  def define_selling_price
    display_market_rates
    @day.set_product_price(yield)
  end

  def select_option
    options_menu {@input.get_input}
  end

  def options_menu
    @viewer.user_options    
    selected_option = yield
    case
    when selected_option == 0
      process_day
    when selected_option == 1
      buy_product {@input.get_input}
      select_option
    when selected_option == 2
      make_product {@input.get_input}
      select_option
    when selected_option == 3
      define_selling_price
      select_option
    when selected_option == 4
      display_weather_report
      select_option
    when selected_option == 5
      display_market_rates
      select_option
    when selected_option == 6
      display_bank_balance
      select_option
    when selected_option == 7
      display_foot_traffic
      select_option
    else
      select_option
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
    @day.stock_to_purchase(yield(@day.inventory.stock.length))

    @viewer.buy_supplies_message
    @day.quantity_to_purchase(yield)

    @day.purchase_stock

    @viewer.insufficient_credit if @day.inventory.insufficient_credit
    @viewer.bank_balance(@day.inventory.money)
    @viewer.product_status(@day.inventory.stock[@day.stock_to_buy], @day.stock_to_buy)
  end

  def make_product
    @viewer.product_select_message
    @day.product_to_make(yield(@day.inventory.sellable_product.length))

    @viewer.product_quantity_message(@day.product)
    @day.quantity_to_make(yield)

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