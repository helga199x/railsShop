class Order < ApplicationRecord
    validates :id_good, :amount, :price, :id_client, presence: true
end
