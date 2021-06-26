require 'rails_helper'

RSpec.describe Stock, type: :model do

    before(:all) {
        year = 2021
        model = "M1"
        cost = 10
        price = 15
        assembly_line = "Bosques"
        @car = Car.create(year: year, model: model, cost: cost, price: price, assembly_line:assembly_line)
    }

    before(:each) {
        @status = "saraza"
    }

    it "is valid with valid attribute" do
        stock = Stock.create(status:@status, car_id:@car.id)
        expect(stock).to be_valid
    end

    it "is not valid without a status" do
        @status = nil
        stock = Stock.create(status:@status, car_id:@car.id)
        expect(stock).to_not be_valid
    end

    it "is not valid without a car" do
        @car.id = nil
        stock = Stock.create(status:@status, car_id:@car.id)
        expect(stock).to_not be_valid
    end

end
