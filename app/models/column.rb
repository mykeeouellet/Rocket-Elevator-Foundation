class Column < ApplicationRecord
    belongs_to :battery
    has_many :elevator
    has_many :intervention
end
