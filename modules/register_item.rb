module RegisterItem
  def register_item(product, price)
    @inventory_tracker.register(product, price)
    puts "Item with the name:#{product.capitalize} has been registered with price: $#{price}"
  end
end
