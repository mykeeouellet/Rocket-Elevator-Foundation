class Address < ApplicationRecord
    belongs_to :entity, polymorphic: true
end
