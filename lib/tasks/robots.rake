namespace :robots do

  desc "Robos Jobs"

  task start_over: :environment do
    builder_robot = BuilderRobotService.new(BasicStructure.new, ElectronicDevices.new, PaintingAndFinalDetails.new)
    builder_robot.start_over
  end

  task building_cars: :environment do
    builder_robot = BuilderRobotService.new(BasicStructure.new, ElectronicDevices.new, PaintingAndFinalDetails.new)
    builder_robot.build_cars(10)
  end

  task detecting_defective_cars: :environment do
    guard_robot = GuardRobotService.new(SlackService.new)
    guard_robot.look_for_defects
  end

  task transferring_cars_from_warehouse_to_store_stock: :environment do
    guard_robot = GuardRobotService.new(SlackService.new)
    guard_robot.transfer_cars_from_warehouse_to_store_stock
  end

  task buying_cars: :environment do
    buyer_robot = BuyerRobotService.new(LoggerService.new)
    amount = rand(1..10)
    buyer_robot.buy_cars(amount)
  end

  task generating_statistics: :environment do
    statistic_service = StatisticService.new
    statistic = statistic_service.calculate_report
    report_service = ReportConsoleService.new(statistic)
    report_service.show_report
  end

end
