require 'rails_helper'

RSpec.describe BuilderRobotService do

    let(:basic_structure) { double("basic_structure") }
    let(:electronic_devices) { double("electronic_devices") }
    let(:painting_and_final_details) { double("painting_and_final_details") }
    let(:builder_robot) {
        BuilderRobotService.new(basic_structure, electronic_devices, painting_and_final_details)
    }

    it "cars should be parked in Warehouse" do
        amount = 6
        car = Car.new(id:1)
        expect(Car).to receive(:create).and_return(car).exactly(amount).times
        expect(Stock).to receive(:create).with(:car_id => car.id, :status => Stock::WAREHOUSE).exactly(amount).times
        expect(basic_structure).to receive(:build_parts).with(car).exactly(amount).times
        expect(electronic_devices).to receive(:build_parts).with(car).exactly(amount).times
        expect(painting_and_final_details).to receive(:build_parts).with(car).exactly(amount).times
        expect(car).to receive(:update).with(:assembly_line => Car::STAGE_COMPLETED).exactly(amount).times
        builder_robot.build_cars(amount)
    end

end