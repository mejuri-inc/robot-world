class BuyerRobotService < RobotService

    def initialize(logger)
        @logger = logger
    end

    def buy_cars(amount)
        amount.times do
            buy_car(random_model())
        end
    end

    private

    def buy_car(model)
        stock = findFirstByModelAndStatus(Stock::STORE, model)
        if stock
            Order.create(stock_id:stock.id)
            stock.update(status:Stock::SOLD)
        else
            @logger.log("There is no available units of [model:" + model + "]")
        end
    end

    def findFirstByModelAndStatus(status, model)
        Stock.select{ |s| s.status == status && s.car.model == model }.first
    end

end