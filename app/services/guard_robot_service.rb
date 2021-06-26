class GuardRobotService < RobotService

    def initialize(message_service)
        @message_service = message_service
    end

    def look_for_defects
        stocks = Stock.select{ |s| s.status == Stock::WAREHOUSE }
        stocks.each do |stock|
            if has_defects(stock.car)
                process_defective_car(stock)
            else # There is no need to wait 30', We can just do it now!
                ready_to_sell(stock)
            end
        end
    end

    # This method 
    def transfer_cars_from_warehouse_to_store_stock
        look_for_defects
    end

    private

    def inform_defect(car)
        computer = car.get_computer
        parts = computer.get_defects
        message = "Car:" + car.id.to_s + " is defective. Check this out: " + parts.to_s
        @message_service.send(message)
    end

    def has_defects(car)
        computer = car.get_computer
        computer.has_defects
    end

    def process_defective_car(stock)
        stock.update(status: Stock::DEFECTIVE)
        inform_defect(stock.car)
    end

    def ready_to_sell(stock)
        stock.update(status: Stock::STORE)
    end

end