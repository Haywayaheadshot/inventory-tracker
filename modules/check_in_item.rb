module CheckInItem
  def check_in_item(product, quantity)
    @inventory_tracker.check_in(product, quantity)
    puts "Stock of item:#{product.capitalize} has increased by #{quantity}"
  end
end
