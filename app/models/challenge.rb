class Challenge < ApplicationRecord
  belongs_to :team
  belongs_to :opponent, optional: true
end
