class BuilderRobotService < RobotService

    def initialize(basic_structure, electronic_Devices, painting_and_final_details)
        @basic_structure = basic_structure
        @electronic_devices = electronic_Devices
        @painting_and_final_details = painting_and_final_details
    end

    def start_over
        Car.destroy_all
    end

    def build_cars(amount)
        amount.times do
            car = build_random_car()
            add_parts(car)
            Stock.create(status:Stock::WAREHOUSE, car_id:car.id)
        end
    end

    private

    def add_parts(car)
        @basic_structure.build_parts(car)
        @electronic_devices.build_parts(car)
        @painting_and_final_details.build_parts(car)
        car.update(assembly_line: Car::STAGE_COMPLETED)
    end

    def build_random_car
        model = random_model()
        cost = random_cost()
        price = calculate_price(cost)
        year = year()
        Car.create(year: year, model: model, cost: cost, price: price)
    end

    def year
        Time.new.year
    end

    def random_cost
        rand(1500..3500)
    end

    def calculate_price(cost)
        cost + 0.3 * cost
    end

end
