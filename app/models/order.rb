class Order < ApplicationRecord

  belongs_to :stock
  has_many :order_changes

end
