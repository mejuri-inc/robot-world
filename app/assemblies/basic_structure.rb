class BasicStructure < AssemblyLine

    AMOUNT_SEATS = 2
    AMOUNT_WHEELS = 4

    def build_parts(car)
        car.update!(assembly_line: Car::STAGE_BASIC_STRUCTURE)
        car.parts.concat(create_part(car, Part::ENGINE))
        car.parts.concat(create_part(car, Part::CHASS))
        car.parts.concat(create_part(car, Part::SEAT, AMOUNT_SEATS))
        car.parts.concat(create_part(car, Part::WHEEL, AMOUNT_WHEELS))
    end

end