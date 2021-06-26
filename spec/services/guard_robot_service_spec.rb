require 'rails_helper'

RSpec.describe GuardRobotService do

    let(:message_service) { double("message_service") }
    let(:guard_robot) { GuardRobotService.new(message_service) }

    it "when a car has defective parts it must be marked as such" do
        stock = build_stock_with_defective_parts()
        expect(Stock).to receive(:select).and_return([stock]).exactly(1).times
        expect(stock).to receive(:update).with(:status => Stock::DEFECTIVE).exactly(1).times
        expect(message_service).to receive(:send).exactly(1).times
        guard_robot.look_for_defects
    end

    it "when a car does not have defective parts it must be parked to the Store" do
        stock = build_stock_without_defective_parts()
        expect(Stock).to receive(:select).and_return([stock]).exactly(1).times
        expect(stock).to receive(:update).with(:status => Stock::STORE).exactly(1).times
        expect(message_service).to receive(:send).exactly(0).times
        guard_robot.look_for_defects
    end

    private

    def build_stock_without_defective_parts
        parts = [ Part.new(name:Part::COMPUTER), Part.new(name:Part::ENGINE) ]
        car = Car.new(parts: parts)
        Stock.new(car:car)
    end

    def build_stock_with_defective_parts
        stock = build_stock_without_defective_parts()
        stock.car.parts.push(Part.new(name:Part::LASER, is_defective: true))
        stock
    end

end
