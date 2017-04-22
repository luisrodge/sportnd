class User < ApplicationRecord
  mount_uploader :profile_image, ProfileImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships

  has_many :started_tournaments, foreign_key: "organizer_id", class_name: 'Tournament'

  has_many :enrollments, dependent: :destroy
  has_many :tournaments, through: :enrollments

  # Pagination for infinite scroll feature
  paginates_per 4

  MAX_ENROLLMENTS = 2

  # Future tournaments for a user
  def upcoming_tournaments
    tournaments.where("date >= ?", Date.today).order("date ASC")
  end

  # Check if the user is not enrolled in another tournament with the date matching this new enrollment's
  # Max of two enrollments, one per weekend-day
  def has_tournament_this_date?(tournament)
    tournaments.where(date: tournament.date).exists?
  end

  def tournament_this_date(tournament)
    tournaments.where(date: tournament.date).first
  end

  # Returns the team a user user is enrolled with for a tournament
  def team_for_tournament(tournament)
    teams.where(tournament_id: tournament).first
  end

  def organized_tournament_this_week?(date)
    tournaments.where(organizer: self).where("Date(date) BETWEEN ? AND ?", date.end_of_week.to_date - 2, date.end_of_week.to_date).exists?
  end

  # Returns true if enrollment limit is reached in a given week for a user
  def enrollment_limit?
    tournaments.where("Date(date) BETWEEN ? AND ?", Date.today.beginning_of_week,
        Date.today.end_of_week).count == MAX_ENROLLMENTS
  end

end
