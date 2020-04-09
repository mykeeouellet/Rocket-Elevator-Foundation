class Customer < ApplicationRecord
    belongs_to :user
    has_many :addresses , as: :entity
    has_many :building
    has_many :quote
    has_many :intervention



end
