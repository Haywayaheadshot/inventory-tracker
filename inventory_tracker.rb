class InventoryTracker
  attr_reader :products, :orders, :inventory

  def initialize
    @products = Hash.new(0.0)
    @inventory = Hash.new(0)
    @orders = Hash.new { |h, k| h[k] = Hash.new(0) }
  end

  def register(product, price)
    @products[product] = price
  end

  def check_in(product, quantity)
    @inventory[product] += quantity
  end

  def order(customer, product, quantity)
    cost = @inventory[product] >= quantity ? @products[product] * quantity : 'n/a'
    @orders[customer] ||= {}
    @orders[customer][product] = cost
    @inventory[product] -= quantity if @inventory[product] >= quantity
  end

  def generate_report
    sorted_customers = @orders.keys.sort

    sorted_customers.each do |customer|
      products = @orders[customer]
      total_spent = 0.0
      orders_info = []

      sorted_products = products.sort.to_h

      sorted_products.each do |product, cost|
        formatted_cost = cost.is_a?(Float) ? format('%.2f', cost) : cost
        orders_info << "#{product} - $#{formatted_cost}"
        total_spent += cost if cost.is_a?(Float)
      end

      if sorted_products.empty? || sorted_products.any? { |_, cost| cost == 'n/a' }
        puts "#{customer.capitalize}: n/a"
      else
        average_order_value = "$#{format('%.2f', (total_spent / sorted_products.size))}"
        puts "#{customer.capitalize}: #{orders_info.join(', ')} | Average Order Value: #{average_order_value}"
      end
    end
  end
end
