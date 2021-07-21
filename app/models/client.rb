class Client < ApplicationRecord
    validates :name, :adress, :phone, presence: true
    has_many :orders, dependent: :destroy
end
