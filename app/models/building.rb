class Building < ApplicationRecord
    belongs_to :customer
    has_one :address , as: :entity
    has_many :building_details
    has_many :battery
end
