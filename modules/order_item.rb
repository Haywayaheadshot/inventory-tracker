module OrderItem
  def order_item(customer, product, quantity)
    @inventory_tracker.order(customer, product, quantity)
    puts "#{customer} ordered #{quantity} #{product.capitalize}(s)"
  end
end
