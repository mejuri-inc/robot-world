require 'json'

class ReportJsonService < ReportService

    def initialize(statistic)
        super(statistic)
    end


    def show_report
        puts(build_report())
    end

    def get_report
        @statistic.to_json
    end

end