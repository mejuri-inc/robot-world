class Stock < ApplicationRecord

  WAREHOUSE = "warehouse"
  DEFECTIVE = "defective"
  STORE     = "store"
  SOLD      = "sold"

  belongs_to :car
  validates_presence_of :status, :car

end
