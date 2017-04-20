class Tournament < ApplicationRecord
  include Obfuscate

  belongs_to :venue
  belongs_to :sport

  belongs_to :organizer, class_name: "User"

  has_many :teams, dependent: :destroy

  has_many :enrollments, dependent: :destroy
  has_many :users, -> { distinct }, through: :enrollments

  validates_presence_of :capacity, :team_size, :bet_amount, :sport_id, :venue_id, :date, :time
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 4 }
  validates :team_size, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 3 }
  validates :bet_amount, numericality: true
  validate :start_new_tournament?, :organized_tournament_this_week?, if: :date

  accepts_nested_attributes_for :teams

  # Pagination for infinite scroll feature
  paginates_per 4

  # Prevents a user from starting a tournament on a date that he/she is already enrolled in another tournament
  def start_new_tournament?
    if self.organizer.has_tournament_this_date?(self)
      errors.add(:date, " - you are already enrolled in a tournament for the entered date, choose another date")
    end
  end

  # Ensures that a user can only start one tournament per week
  def organized_tournament_this_week?
    if self.organizer.organized_tournament_this_week?(self.date)
      errors.add(:date, " - you have already started a tournament for the week relative to the entered date. You are limited to start one tournament per week, choose another date")
    end
  end

  def self.upcoming
    where('date >= ?', Date.today)
  end

  # Returns true if a user is enrolled in a tournament
  def enrolled?(user)
    user.teams.where(tournament_id: self).any?
  end

  # Tournaments with available space either via new team enrollment or team membership
  def self.open
    #joins(:teams).group("tournaments.id").having("count(teams.id) < tournaments.capacity")
    joins(:users).group("tournaments.id").having("count(users.id) < (tournaments.capacity * tournaments.team_size)")
  end

  # Is a tournament already full?
  def full?
    users.count == (capacity * team_size)
    #joins(:users).group("tournaments.id").having("count(users.id) < ? ", (capacity * team_size))
  end

  # Remaining space for new team enrollments
  def remaining_capacity
    capacity - teams.count
  end

  # Number of teams with available space in a tournament
  def teams_with_space
    teams.joins(:users).group("teams.id").having("count(users.id) < ?", team_size).each.count
    #(tournaments.capacity * tournaments.team_size) - (tournaments.users)
  end

  # Returns true if the tournament is still in enrollment period
  def enrollment_period?
    if Date.today.strftime("%U").to_i < date.strftime("%U").to_i
      return true
    elsif Date.today.strftime("%U").to_i == date.strftime("%U").to_i
      if  Date.today <= date.end_of_week - 2
        return true
      else
        return false
      end
    end
    false
  end

  # Total bet amount for tournament
  # Taking into account capacity and members per team
  def total_bet_amount
    (bet_amount * capacity) * team_size
  end

  # The current bet total with respect to enrolled teams and their members
  def current_bet_amount
    total = 0.0
    teams.each do |team|
      total += team.users.count * bet_amount
    end
    total
  end

  # Returns a percentage of the current bet amount
  def bet_amount_percentage
    (((current_bet_amount - 0) / (total_bet_amount - 0)) * 100).round.to_s + '%'
  end

end
