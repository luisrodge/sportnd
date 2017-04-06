class Tournament < ApplicationRecord
  belongs_to :venue
  belongs_to :sport

  belongs_to :organizer, class_name: "User"

  #has_many :enrollments, dependent: :destroy
  has_many :teams, dependent: :destroy

  has_many :enrollments, dependent: :destroy
  has_many :users, -> { distinct }, through: :enrollments

  paginates_per 4

  def enrolled?(user)
    user.teams.where(tournament_id: self).any?
  end

  def self.open
  	where(status: "enroll")
  end

  def allow_enrollment?
    return true if Date.today.strftime("%U").to_i <= date.strftime("%U").to_i
    false
  end

  def total_bet_amount
    (bet_amount * capacity) * team_size
  end

  def current_bet_amount
    total = 0.0
    teams.each do |team| 
      total += team.users.count * bet_amount
    end
    total
  end

  def bet_amount_percentage
    (((current_bet_amount - 0) / (total_bet_amount - 0)) * 100).round.to_s + '%'
  end

end
