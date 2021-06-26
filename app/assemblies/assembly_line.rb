class AssemblyLine

    DEFECTIVE_PROBABILITY = 0.0025

    def create_part(car, name, count = 1)
        parts = []
        count.times do
            part = Part.create(car_id:car.id, name:name, is_defective:calculate_random_defect)
            parts.push(part)
        end
        parts
    end

    private

    def calculate_random_defect
        rand < DEFECTIVE_PROBABILITY
    end

end
