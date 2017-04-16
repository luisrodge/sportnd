class TournamentPolicy < ApplicationPolicy
  def new?
    return true if Date.today.saturday? || Date.today.sunday?
  end
end
