class Team < ApplicationRecord
	has_many :memberships, dependent: :destroy
	has_many :users, -> { distinct }, through: :memberships

	has_one :captain_membership, -> { where captain: true}, class_name: 'Membership', dependent: :destroy
  has_one :captain, through: :captain_membership, source: :user

  belongs_to :tournament
	belongs_to :color

	validates_presence_of :color

	# Pagination for infinite scroll feature
  paginates_per 6

	def is_member?(user)
		users.exists?(user)
	end

	def remaining_space
		tournament.team_size - users.count
	end

	# Teams that a member can join under certain conditions
	# A member can join if a team has space & the tournament date is in the future
	def self.enrolled_in_tournaments
		#joins(:users).joins(:tournament).group("teams.id").having("count(users.id) <  tournaments.team_size").select{ |t| t.tournament.enrollment_period? == true }
		joins(:users).joins(:tournament).group("teams.id").group("tournaments.id").having("count(users.id) <  tournaments.team_size AND DATE(tournaments.date) > ?", Date.today).order("created_at DESC")
	end

end
