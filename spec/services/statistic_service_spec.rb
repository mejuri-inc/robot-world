require 'rails_helper'

RSpec.describe StatisticService do

    let(:statistic_service) { StatisticService.new }

    it "if there are no orders, there is nothing sold" do
        order = nil
        expect(Order).to receive(:all).and_return([]).exactly(1).times
        report = statistic_service.calculate_report
        expect(report.status[Stock::DEFECTIVE]).to eq nil
        expect(report.status[Stock::WAREHOUSE]).to eq nil
        expect(report.status[Stock::STORE]).to eq nil
        expect(report.status[Stock::SOLD]).to eq nil
        expect(report.total_sold).to eq 0
        expect(report.total_price).to eq 0
        expect(report.revenues).to eq 0
    end

    it "if there is a car in the Warehouse, then the total of cars is 1" do
        order = build_order(Stock::WAREHOUSE, "M1")
        expect(Order).to receive(:all).and_return([order]).exactly(1).times
        report = statistic_service.calculate_report
        expect(report.status[Stock::DEFECTIVE]).to eq nil
        expect(report.status[Stock::WAREHOUSE].total).to eq 1
        expect(report.status[Stock::STORE]).to eq nil
        expect(report.status[Stock::SOLD]).to eq nil
        expect(report.total_sold).to eq 1
        expect(report.total_price).to eq 0
        expect(report.revenues).to eq 0
    end

    it "if there is a defective car, then the total of cars is 1" do
        order = build_order(Stock::DEFECTIVE, "M1")
        expect(Order).to receive(:all).and_return([order]).exactly(1).times
        report = statistic_service.calculate_report
        expect(report.status[Stock::DEFECTIVE].total).to eq 1
        expect(report.status[Stock::WAREHOUSE]).to eq nil
        expect(report.status[Stock::STORE]).to eq nil
        expect(report.status[Stock::SOLD]).to eq nil
        expect(report.total_sold).to eq 1
        expect(report.total_price).to eq 0
        expect(report.revenues).to eq 0
    end

    it "if there is a car in the Store, then the total of cars is 1" do
        order = build_order(Stock::STORE, "M1")
        expect(Order).to receive(:all).and_return([order]).exactly(1).times
        report = statistic_service.calculate_report
        expect(report.status[Stock::DEFECTIVE]).to eq nil
        expect(report.status[Stock::WAREHOUSE]).to eq nil
        expect(report.status[Stock::STORE].total).to eq 1
        expect(report.status[Stock::SOLD]).to eq nil
        expect(report.total_sold).to eq 1
        expect(report.total_price).to eq 0
        expect(report.revenues).to eq 0
    end

    it "if there is a sold car, then the total of cars is 1 and there are revenues" do
        order = build_order(Stock::SOLD, "M1")
        expect(Order).to receive(:all).and_return([order]).exactly(1).times
        report = statistic_service.calculate_report
        expect(report.status[Stock::DEFECTIVE]).to eq nil
        expect(report.status[Stock::WAREHOUSE]).to eq nil
        expect(report.status[Stock::STORE]).to eq nil
        expect(report.status[Stock::SOLD].total).to eq 1
        expect(report.total_sold).to eq 1
        expect(report.total_price).to eq 100
        expect(report.revenues).to eq 40
    end

    it "if there are two cars sold, then the total of cars is 2 and there are revenues" do
        order1 = build_order(Stock::SOLD, "M1")
        order2 = build_order(Stock::SOLD, "M1")
        expect(Order).to receive(:all).and_return([order1, order2]).exactly(1).times
        report = statistic_service.calculate_report
        expect(report.status[Stock::DEFECTIVE]).to eq nil
        expect(report.status[Stock::WAREHOUSE]).to eq nil
        expect(report.status[Stock::STORE]).to eq nil
        expect(report.status[Stock::SOLD].total).to eq 2
        expect(report.total_sold).to eq 2
        expect(report.total_price).to eq 200
        expect(report.revenues).to eq 80
    end

    it "if there are four cars sold, then the total of cars is 4 and there are revenues" do
        order1 = build_order(Stock::WAREHOUSE, "M1")
        order2 = build_order(Stock::DEFECTIVE, "M1")
        order3 = build_order(Stock::STORE, "M1")
        order4 = build_order(Stock::SOLD, "M1")
        expect(Order).to receive(:all).and_return([order1, order2, order3, order4]).exactly(1).times
        report = statistic_service.calculate_report
        expect(report.status[Stock::DEFECTIVE].total).to eq 1
        expect(report.status[Stock::WAREHOUSE].total).to eq 1
        expect(report.status[Stock::STORE].total).to eq 1
        expect(report.status[Stock::SOLD].total).to eq 1
        expect(report.total_sold).to eq 4
        expect(report.total_price).to eq 100
        expect(report.revenues).to eq 40
    end

    it "if an order changes, then the statistics also change" do
        order = build_order(Stock::SOLD, "M1")
        expect(Order).to receive(:all).and_return([order]).exactly(2).times

        report = statistic_service.calculate_report
        expect(report.status[Stock::DEFECTIVE]).to eq nil
        expect(report.status[Stock::WAREHOUSE]).to eq nil
        expect(report.status[Stock::STORE]).to eq nil
        expect(report.status[Stock::SOLD].total).to eq 1
        expect(report.total_sold).to eq 1
        expect(report.total_price).to eq 100
        expect(report.revenues).to eq 40

        stock = build_stock(Stock::SOLD, "M2")
        order_change = OrderChange.new(stock:stock)
        order.order_changes.push(order_change)
        report = statistic_service.calculate_report

        expect(report.status[Stock::DEFECTIVE]).to eq nil
        expect(report.status[Stock::WAREHOUSE]).to eq nil
        expect(report.status[Stock::STORE]).to eq nil
        expect(report.status[Stock::SOLD].total).to eq 1
        expect(report.total_sold).to eq 1
        expect(report.total_price).to eq 400
        expect(report.revenues).to eq 200
    end

    private

    def build_car(model)
        price = 100
        cost = 60
        if model == "M2"
            price = 400
            cost = 200
        end
        Car.new(price:price, cost:cost, model:model)
    end

    def build_stock(status, model)
        car = build_car(model)
        Stock.new(id:1, car:car, status:status)
    end

    def build_order(status, model)
        stock = build_stock(status, model)
        Order.new(stock:stock)
    end

end