class OrderChangeService

    class OrderNotFoundError < StandardError; end
    class StockNotAvailableError < StandardError; end

    def change_order(order_id, model)
        order = Order.find_by(id:order_id)
        if !order
            raise OrderNotFoundError, "The order_id:" + order_id.to_s + " does not exist"
        end
        checkStock(order, model)
    end

    private

    def checkStock(order, model)
        available_stock = findFirstByModelAndStatus(Stock::STORE, model)
        if !available_stock
            raise StockNotAvailableError, "There is not stock available for the model:" + model
        end
        createOrderChange(order, available_stock)
    end

    def createOrderChange(order, available_stock)
        current_stock = findCurrentStock(order)
        current_stock.update(status:Stock::STORE)
        available_stock.update(status:Stock::SOLD)
        OrderChange.create(order_id:order.id, stock_id:available_stock.id)
    end

    def findFirstByModelAndStatus(status, model)
        Stock.select{ |s| s.status == status && s.car.model == model }.first
    end

    def findCurrentStock(order)
        stock = nil
        order_change = order.order_changes.last
        if order_change
            stock = order_change.stock
        else
            stock = order.stock
        end
        stock
    end

end