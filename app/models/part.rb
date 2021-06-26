class Part < ApplicationRecord

    belongs_to :car
    validates_presence_of :car, :name


    ENGINE   = "Engine"
    CHASS    = "Chass"
    SEAT     = "Seat"
    WHEEL    = "Wheel"
    LASER    = "Laser"
    COMPUTER = "Computer"

    def has_defects
        car.parts.any? { |p| p.is_defective }
    end

    def get_defects
        car.parts
            .select { |p| p.is_defective }
            .map { |p| p.name + ":" + p.id.to_s }
    end

end
