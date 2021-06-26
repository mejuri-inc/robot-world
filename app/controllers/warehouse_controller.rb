class WarehouseController < ApplicationController

  def cars_by_model
    begin
      model = params[:model]
      Stock.select { |c| }
      order_service = OrderChangeService.new
      order_service.change_order(order_id, model)
      render(json: { description: "The change was registered" }, status: 201)
    rescue OrderChangeService::OrderNotFoundError, OrderChangeService::StockNotAvailableError => e
      render(json: { description: e.message }, status: 404)
    end
  end

end
