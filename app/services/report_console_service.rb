class ReportConsoleService < ReportService

    def initialize(statistic)
        super(statistic)
    end

    def show_report
        puts(build_report())
    end

    def get_report
        build_report()
    end

    private

    def build_report
        title() +
        build_key_value_info("Total Cars ", "#{@statistic.total_sold.to_s}") +
        build_key_hash_info("Defective", @statistic.status[Stock::DEFECTIVE]) +
        build_key_hash_info("Warehouse", @statistic.status[Stock::WAREHOUSE]) +
        build_key_hash_info("Stock", @statistic.status[Stock::STORE]) +
        build_key_hash_info("Sold", @statistic.status[Stock::SOLD]) +
        build_key_value_info("Revenues ", "#{@statistic.revenues.to_s}") +
        build_key_value_info("Average Order Value ", "#{@statistic.average_order_value}")
    end

    def title
        "Statistic\n"
    end

    def build_key_value_info(key, value)
        " - " + key.ljust(30, '.') + " " + value+ "\n"
    end

    def build_key_hash_info(key, info)
        if info
            pretty_models = build_pretty_models(info.models)
            build_key_value_info(key + " Cars  ", "#{info.total.to_s} => #{pretty_models}")
        else
            build_key_value_info(key + " Cars  ", "0")
        end
    end

    def build_pretty_models(models)
        ms = ""
        models.each do |key, value|
            ms = ms + "[#{key},#{value}] "
        end
        ms
    end

end