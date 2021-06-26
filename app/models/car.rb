class Car < ApplicationRecord

    validates_presence_of :model, :year, :price, :cost
    has_many :parts

    STAGE_BASIC_STRUCTURE            = "BasicStructure"
    STAGE_ELECTRONIC_DEVICES         = "ElectronicDevices"
    STAGE_PAINTING_AND_FINAL_DETAILS = "PaintingAndFinalDetails"
    STAGE_COMPLETED                  = "Completed"

    def get_computer
        parts.find { |p| p.name == Part::COMPUTER }
    end

end
