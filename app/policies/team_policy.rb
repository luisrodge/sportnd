class TeamPolicy < ApplicationPolicy
  def join?
    return true if !record.tournament.enrolled?(member) &&
      record.members.count < record.tournament.team_size &&
      !user.has_tournament_this_date?(record.tournament)
  end
end
