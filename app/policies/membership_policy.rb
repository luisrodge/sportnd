class MembershipPolicy < ApplicationPolicy
  def create?
    return true if record.remaining_space != 0 && record.tournament.enrollment_period? &&
      !user.has_tournament_this_date?(record.tournament) && !record.tournament.enrolled?(user) 
  end
end
