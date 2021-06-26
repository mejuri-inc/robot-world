class PaintingAndFinalDetails < AssemblyLine

    def build_parts(car)
        car.update!(assembly_line: Car::STAGE_PAINTING_AND_FINAL_DETAILS)
        # final set-up!
    end

end
