class User < ApplicationRecord
  mount_uploader :profile_image, ProfileImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships

  has_many :started_tournaments, foreign_key: "organizer_id", class_name: 'Tournament'

  has_many :enrollments, dependent: :destroy
  has_many :tournaments, through: :enrollments

  MAX_ENROLLMENTS = 2

  # Check if the user is not enrolled in another tournament with the date matching this new enrollment's
  # Max of two enrollments, one per weekend-day
  def has_tournament_this_date?(tournament)
    tournaments.where(date: tournament.date).exists?
  end

  # Returns the team a user user is enrolled with for a tournament
  def team_for_tournament(tournament)
    teams.where(tournament_id: tournament).first
  end

  # Start a new tournament only if a user hasn't already started one for the weekend already
  # A user can only start and organize one tournament for a weekend every week
  # A user can only start a tournament on the weekends
  def start_new_tournament?
    if ((tournaments.where("Date(date) BETWEEN ? AND ?", Date.today.beginning_of_week,
        Date.today.end_of_week).where(organizer: self).empty?) || (Date.today.saturday? || Date.today.sunday?))
        return true
    end
    false
  end

  # Returns true if enrollment limit is reached in a given week for a user
  def enrollment_limit?
    tournaments.where("Date(date) BETWEEN ? AND ?", Date.today.beginning_of_week,
        Date.today.end_of_week).count == MAX_ENROLLMENTS
  end

end
