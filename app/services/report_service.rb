class ReportService

    def initialize(statistic)
        @statistic = statistic
    end

    def show_report
        raise NoMethodError, "#{self.class} #send is abstract and must be implemened in the subclass"
    end

    def get_report
        raise NoMethodError, "#{self.class} #send is abstract and must be implemened in the subclass"
    end

end