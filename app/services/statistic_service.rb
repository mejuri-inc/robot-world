class StatisticService

    class Statistic
        attr_accessor :total_sold, :total_price, :average_order_value, :revenues, :status

        class Info
            attr_accessor :total, :models
            def initialize
                @total = 0
                @models = Hash.new
            end
        end

        def initialize
            @total_sold = 0
            @total_price = 0
            @revenues = 0
            @average_order_value = 0
            @status = Hash.new
        end
    end

    def calculate_report
        statistic = Statistic.new
        process_orders(statistic)
        process_stock_no_sold(statistic)
        statistic
    end

    private

    def process_stock_no_sold(statistic)
        stocks = Stock.all.select { |s| s.status != Stock::SOLD}
        stocks.each do |stock|
            calculate_report_for_stock(statistic, stock)
        end
    end

    def process_orders(statistic)
        orders = Order.all
        orders.each do |order|
            calculate_report_for_order(statistic, order)
        end
    end

    def calculate_report_for_order(statistic, order)
        stock = get_stock(order)
        calculate_report_for_stock(statistic, stock)
    end

    def get_stock(order)
        stock = nil
        order_change = order.order_changes.last
        if order_change
            stock = order_change.stock
        else
            stock = order.stock
        end
        stock
    end

    def calculate_report_for_stock(statistic, stock)
        car = stock.car
        model = car.model
        state = stock.status
        check_initial_values(statistic, state, model)
        statistic.total_sold = statistic.total_sold + 1
        statistic.status[state].total = statistic.status[state].total + 1
        statistic.status[state].models[model] = statistic.status[state].models[model] + 1
        if state == Stock::SOLD
            calculate_sold(statistic, state, car)
        end
    end

    def calculate_sold(statistic, state, car)
        statistic.total_price = statistic.total_price + car.price
        statistic.revenues = statistic.revenues + (car.price - car.cost)
        statistic.average_order_value = (statistic.total_price / statistic.status[state].total).round(2)
    end

    def check_initial_values(statistic, state, model)
        check_initial_status(statistic, state)
        check_initial_models(statistic, state, model)
    end

    def check_initial_status(statistic, state)
        if !statistic.status[state]
            statistic.status[state] = Statistic::Info.new
        end
    end

    def check_initial_models(statistic, state, model)
        if !statistic.status[state].models[model]
            statistic.status[state].models[model] = 0
        end
    end

end
