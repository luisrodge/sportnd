class Team < ApplicationRecord
	has_many :memberships, dependent: :destroy
	has_many :users, -> { distinct }, through: :memberships

	has_one :captain_membership, -> { where captain: true}, class_name: 'Membership', dependent: :destroy
  has_one :captain, through: :captain_membership, source: :user

  belongs_to :tournament
	belongs_to :color

	validates_presence_of :color

	# Pagination for infinite scroll feature
  paginates_per 4

	def is_member?(user)
		users.exists?(user)
	end

	def remaining_space
		tournament.team_size - users.count
	end

	# Teams that a member can join given under certain conditions
	def self.enrolled_in_tournaments
		joins(:users).joins(:tournament).group("teams.id").having("count(users.id) <  tournaments.team_size AND DATE(tournaments.date) > ?", Date.today)
	end

end
