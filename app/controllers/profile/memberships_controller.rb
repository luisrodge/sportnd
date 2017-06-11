class Profile::MembershipsController < ApplicationController
  before_action :authenticate_member!

  # User joins an existing team in a tournament
  # Add user to tournament users
  def create
    team = Team.find(params[:team_id])

    authorize(Membership.where(team: team).first)
    team.users << current_member
    team.tournament.users << current_member
    redirect_to team.tournament
  end

  # User leaves a team
  # Remove user from team users
  # Remove user from tournament users
  def destroy
    team = Team.find(params[:team_id])
    team.users.delete(current_member)
    team.tournament.members.delete(current_member)
    redirect_to team.tournament
  end

end
