class TeamPolicy < ApplicationPolicy
  def join?
    return true if !record.tournament.enrolled?(user) &&
      record.users.count < record.tournament.team_size &&
      !user.has_tournament_this_date?(record.tournament)
  end
end
