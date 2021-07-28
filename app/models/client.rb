class Client < ApplicationRecord
  validates :name, :adress, :phone, presence: true, format: {with: /[a-zA-Z\d]/}
  has_many :orders, dependent: :destroy
end
