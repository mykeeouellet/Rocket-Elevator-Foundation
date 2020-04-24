class Intervention < ApplicationRecord
  validates :report, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  belongs_to :customer,  optional: true
  belongs_to :building,  optional: true
  belongs_to :battery,  optional: true
  belongs_to :column,  optional: true
  belongs_to :elevator,  optional: true
  belongs_to :employee,  optional: true
end
