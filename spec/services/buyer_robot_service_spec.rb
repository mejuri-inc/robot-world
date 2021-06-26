require 'rails_helper'

RSpec.describe BuyerRobotService do

    let(:logger) { double("logger") }
    let(:stock) { double(Stock)}
    let(:buyer_robot) { BuyerRobotService.new(logger) }

    it "if there are no cars in the store then should not be able to buy a car" do
        available_stock = nil
        expect(Stock).to receive(:select).and_return(stock).exactly(1).times
        expect(stock).to receive(:first).and_return(available_stock).exactly(1).times
        expect(Order).to receive(:create).exactly(0).times
        expect(stock).to receive(:update).exactly(0).times
        expect(logger).to receive(:log).exactly(1).times
        buyer_robot.buy_cars(1)
    end

    it "if there are cars in the store then should be able to buy a car" do
        available_stock = Stock.new(id:88)
        expect(Stock).to receive(:select).and_return(stock).exactly(1).times
        expect(stock).to receive(:first).and_return(available_stock).exactly(1).times
        expect(Order).to receive(:create).with(:stock_id => available_stock.id).exactly(1).times
        expect(available_stock).to receive(:update).with(:status => Stock::SOLD).exactly(1).times
        expect(logger).to receive(:log).exactly(0).times
        buyer_robot.buy_cars(1)
    end

end
