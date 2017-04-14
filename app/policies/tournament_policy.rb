class TournamentPolicy < ApplicationPolicy
  def new?
    user.start_new_tournament?
  end
end
