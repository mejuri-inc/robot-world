set :output, "log/cron.log"
env :PATH, ENV['PATH']

every 1.minute do
    rake 'robots:building_cars'
end

every 1.minute do
    rake 'robots:detecting_defective_cars'
end

every 30.minute do
    rake 'robots:transferring_cars_from_warehouse_to_store_stock'
end

every 1.minute do
    rake 'robots:buying_cars'
end

every 1.minute do
    rake 'robots:generating_statistics'
end

every 1.day, at: '00:00 am' do
    rake 'robots:star_over'
end
