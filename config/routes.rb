Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/order/:orderId/changes/:model', to: 'order_change#change_order'
  get '/statistic', to: 'statistic#get_statistic'
  get '/car/:carId', to: 'car#get_car'
end
