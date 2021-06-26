class RobotService

    MODELS = [ "M1", "M2", "M3", "M4", "M5", "M6", "M7", "M8", "M9", "M10" ]

    def random_model
        MODELS[rand(10)]
    end

end