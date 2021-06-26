require 'rails_helper'

RSpec.describe Part, type: :model do

    before(:all) {
        year = 2021
        model = "M1"
        cost = 10
        price = 15
        @assembly_line = "Bosques"
        @car = Car.create(year: year, model: model, cost: cost, price: price, assembly_line:@assembly_line)
    }

    before(:each) {
        @is_defective = false
        @name = "saraza"
    }

    it "is valid with valid attribute" do
        part = Part.create(car_id:@car.id, name:@name, is_defective:@is_defective)
        expect(part).to be_valid
    end

    it "is not valid without a name" do
        @name = nil
        part = Part.create(car_id:@car.id, name:@name, is_defective:@is_defective)
        expect(part).to_not be_valid
    end

    it "is not valid without a car" do
        @car.id = nil
        part = Part.create(car_id:@car.id, name:@name, is_defective:@is_defective)
        expect(part).to_not be_valid
    end

end
