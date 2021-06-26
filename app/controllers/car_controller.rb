class CarController < ApplicationController

  def get_car
    begin
      car_id = params[:carId]
      car = Car.find(car_id)
      render(json:car , status: 200)
    rescue ActiveRecord::RecordNotFound  
      render(json: { description: "The car_id:" + car_id + " does not exit" }, status: 404)
    return
    end
  end

end