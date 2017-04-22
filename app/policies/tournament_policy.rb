class TournamentPolicy < ApplicationPolicy
  def new?
    return true if Date.today.saturday? || Date.today.sunday?
  end

  def destroy?
    return true if record.organizer == user
  end
end
