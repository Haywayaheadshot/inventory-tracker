require_relative '../inventory_tracker'

RSpec.describe InventoryTracker do
  let(:tracker) { InventoryTracker.new }

  describe '#register' do
    it 'registers a product with the given price' do
      tracker.register('hats', 20.50)
      expect(tracker.products['hats']).to eq(20.50)
    end
  end

  describe '#check_in' do
    it 'increases the inventory quantity for the given product' do
      tracker.register('hats', 20.50)
      tracker.check_in('hats', 100)
      expect(tracker.inventory['hats']).to eq(100)
    end
  end

  describe '#order' do
    before do
      tracker.register('hats', 20.50)
      tracker.register('socks', 3.45)
      tracker.check_in('hats', 100)
      tracker.check_in('socks', 30)
    end

    it 'places an order for a product from a customer' do
      tracker.order('kate', 'hats', 20)
      expect(tracker.orders['kate']['hats']).to eq(410.00)
      expect(tracker.inventory['hats']).to eq(80)
    end

    it 'handles orders when inventory is insufficient' do
      tracker.order('dan', 'socks', 40)
      expect(tracker.orders['dan']['socks']).to eq('n/a')
      expect(tracker.inventory['socks']).to eq(30)
    end
  end

  describe '#generate_report' do
    it 'generates the correct report' do
      tracker.register('hats', 20.50)
      tracker.register('socks', 3.45)
      tracker.check_in('hats', 100)
      tracker.order('kate', 'hats', 20)
      tracker.check_in('socks', 30)
      tracker.order('dan', 'socks', 35)
      tracker.order('kate', 'socks', 10)

      expected_output = <<~EXPECTED
        Dan: n/a
        Kate: hats - $410.00, socks - $34.50 | Average Order Value: $222.25
      EXPECTED

      expect { tracker.generate_report }.to output(expected_output).to_stdout
    end
  end
end
