class StatisticController < ApplicationController

  def get_statistic
    statistic_service = StatisticService.new
    statistic = statistic_service.calculate_report
    report_service = ReportJsonService.new(statistic)
    report = report_service.get_report
    render(json: report, status: 200)
  end

end
