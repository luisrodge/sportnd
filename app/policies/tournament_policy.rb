class TournamentPolicy < ApplicationPolicy
  def new?
    return true if (Date.today.saturday? || Date.today.sunday?) && !(user.organized_for_upcoming_week?)
  end

  def destroy?
    return true if record.organizer == user
  end
end
