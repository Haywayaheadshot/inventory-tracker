module GenerateReport
  def generate_report(inventory_tracker)
    if inventory_tracker.orders.empty?
      puts 'There are no orders to be reported!'
    else
      @inventory_tracker.generate_report
    end
  end
end
