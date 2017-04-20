class Profile::MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    team = Team.find(params[:team_id])
    team.users << current_user
    team.tournament.users << current_user
    redirect_to team.tournament
  end

  def destroy
    team = Team.find(params[:team_id])
    team.users.delete(current_user)
    team.tournament.users.delete(current_user)
    redirect_to team.tournament
  end

end
