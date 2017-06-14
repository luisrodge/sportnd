class Team < ApplicationRecord
	has_many :memberships, dependent: :destroy
	has_many :members, -> { distinct }, through: :memberships

	has_one :captain_membership, -> { where captain: true}, class_name: 'Membership', dependent: :destroy
  has_one :captain, through: :captain_membership, source: :member

  belongs_to :tournament
	belongs_to :color

	validates_presence_of :color

	# Pagination for infinite scroll feature
  paginates_per 6

	def is_member?(member)
		members.exists?(member)
	end

	def remaining_space
		tournament.team_size - members.count
	end

	# Teams that a member can join under certain conditions
	# A member can join if a team has space & the tournament date is in the future
	# Friends on facebook
	def self.enrolled_in_tournaments
		joins(:members).joins(:tournament).group("teams.id").group("tournaments.id").having("count(members.id) <  tournaments.team_size AND tournaments.eowd_date >= ?", Date.today).order("created_at DESC")
	end

end
