class ElectronicDevices < AssemblyLine

    def build_parts(car)
        car.update!(assembly_line: Car::STAGE_ELECTRONIC_DEVICES)
        car.parts.concat(create_part(car, Part::LASER))
        car.parts.concat(create_part(car, Part::COMPUTER))
    end

end