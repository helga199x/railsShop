class Order < ApplicationRecord
    validates :id_good, :amount, :price, :id_client, presence: true
    validates :id_good, :id_client, :price, :amount, numericality: { greater_than: 0 }
end
