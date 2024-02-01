require_relative 'inventory_tracker'
require_relative 'modules/exit_app'
require_relative 'modules/on_start'
require_relative 'modules/register_item'
require_relative 'modules/check_in_item'
require_relative 'modules/order_item'
require_relative 'modules/generate_report'

class App
  attr_reader :inventory_tracker

  def initialize
    @inventory_tracker = InventoryTracker.new
  end

  include OnStart
  include ExitApp
  include RegisterItem
  include CheckInItem
  include OrderItem
  include GenerateReport
end
