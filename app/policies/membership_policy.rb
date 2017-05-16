class MembershipPolicy < ApplicationPolicy
  def create?
    return true if record.team.remaining_space != 0 && record.team.tournament.enrollment_period? &&
      !user.has_tournament_this_date?(record.team.tournament) && !record.team.tournament.enrolled?(user) &&
      user.is_friend?(record.team.captain)
  end
end
