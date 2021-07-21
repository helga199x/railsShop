class Good < ApplicationRecord
    has_one_attached :storage_image
    has_many :orders, dependent: :destroy
end
