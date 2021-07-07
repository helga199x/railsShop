class Client < ApplicationRecord
    validates :name, :adress, :phone, presence: true
end
