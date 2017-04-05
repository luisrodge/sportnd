class Team < ApplicationRecord
	has_many :memberships, dependent: :destroy
	has_many :users, -> { distinct }, through: :memberships

	has_one :captain_membership, -> { where captain: true}, class_name: 'Membership'
  	has_one :captain, through: :captain_membership, source: :user

  	belongs_to :tournament
  	
end
