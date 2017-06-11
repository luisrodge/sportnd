class TournamentPolicy < ApplicationPolicy
  def new?
    return true if !(member.organized_for_upcoming_week?) && (Date.today.saturday? || Date.today.sunday?)
  end

  def destroy?
    return true if record.organizer == member
  end
end
