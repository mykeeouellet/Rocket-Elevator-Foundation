class Quote < ApplicationRecord
   belongs_to :customer, optional: true
end