require 'rails_helper'

RSpec.describe Car, type: :model do

    before(:each) {
        @model = "M1"
        @year = 2021
        @cost = 10
        @price = 15
        @assembly_line = "Bosques"
    }

    it "is valid with valid attribute" do
        car = Car.new(model:@model, year:@year, cost:@cost, price:@price, assembly_line:@assembly_line)
        expect(car).to be_valid
    end

    it "is not valid without a year" do
        @year = nil
        car = Car.new(model:@model, year:@year, cost:@cost, price:@price, assembly_line:@assembly_line)
        expect(car).to_not be_valid
    end

    it "is not valid without a cost" do
        @cost = nil
        car = Car.new(model:@model, year:@year, cost:@cost, price:@price, assembly_line:@assembly_line)
        expect(car).to_not be_valid
    end

    it "is not valid without a price" do
        @price = nil
        car = Car.new(model:@model, year:@year, cost:@cost, price:@price, assembly_line:@assembly_line)
        expect(car).to_not be_valid
    end

    it "is not valid without a model" do
        @model = nil
        car = Car.new(model:@model, year:@year, cost:@cost, price:@price, assembly_line:@assembly_line)
        expect(car).to_not be_valid
    end

    it "is not valid without a assembly line" do
        @model = nil
        car = Car.new(model:@model, year:@year, cost:@cost, price:@price, assembly_line:@assembly_line)
        expect(car).to_not be_valid
    end

end
