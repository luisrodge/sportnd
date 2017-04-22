class Profile::MembershipsController < ApplicationController
  before_action :authenticate_user!

  # User joins an existing team in a tournament
  # Add user to tournament users
  def create
    team = Team.find(params[:team_id])
    team.users << current_user
    team.tournament.users << current_user
    redirect_to team.tournament
  end

  # User leaves a team
  # Remove user from team users
  # Remove user from tournament users
  def destroy
    team = Team.find(params[:team_id])
    team.users.delete(current_user)
    team.tournament.users.delete(current_user)
    redirect_to team.tournament
  end

end
