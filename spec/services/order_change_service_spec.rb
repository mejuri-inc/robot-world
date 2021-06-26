require 'rails_helper'

RSpec.describe OrderChangeService do

    let(:order) { Order.new(id:1, stock:Stock.new) }
    let(:stock) { double(Stock)}
    let!(:order_service) {
        @model = "M1"
        OrderChangeService.new
    }

    it "should change the order when there is stock for the requested model" do
        expect(Order).to receive(:find_by).with(:id => order.id).and_return(order)
        available_stock = Stock.new(id:88)
        expect(Stock).to receive(:select).and_return(stock).exactly(1).times
        expect(stock).to receive(:first).and_return(available_stock).exactly(1).times
        expect(order.stock).to receive(:update).with(:status => Stock::STORE).exactly(1).times
        expect(available_stock).to receive(:update).with(:status => Stock::SOLD).exactly(1).times
        expect(OrderChange).to receive(:create).with(:order_id => order.id, :stock_id => available_stock.id).exactly(1).times
        order_service.change_order(order.id, @model)
    end

    it "should throw an exception when there is no order" do
        expect(Order).to receive(:find_by).with(:id => order.id).and_return(nil)
        expect(Stock).to receive(:select).exactly(0).times
        expect(stock).to receive(:first).exactly(0).times
        expect(OrderChange).to receive(:create).exactly(0).times
        expect { order_service.change_order(order.id, @model) }.to raise_error(OrderChangeService::OrderNotFoundError)
    end

    it "should throw an exception when there is no stock" do
        expect(Order).to receive(:find_by).with(:id => order.id).and_return(order)
        available_stock = nil
        expect(Stock).to receive(:select).and_return(stock).exactly(1).times
        expect(stock).to receive(:first).and_return(available_stock).exactly(1).times
        expect(OrderChange).to receive(:create).exactly(0).times
        expect { order_service.change_order(order.id, @model) }.to raise_error(OrderChangeService::StockNotAvailableError)
    end

end