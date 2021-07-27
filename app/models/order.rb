class Order < ApplicationRecord
    validates :good_id, :amount, :price, :client_id, presence: true
    validates :good_id, :client_id, :price, :amount, numericality: { greater_than: 0 }

    belongs_to :good
    belongs_to :client
end
