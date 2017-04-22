class Profile::TeamsController < ApplicationController
  before_action :authenticate_user!

  def new
  	@team = Team.new
  end

  # Associate new team for a tournament
  # Associate the current user to tournament
  def create
    @tournament = Tournament.find_by_hash_id!(params[:tournament_id])
    team = @tournament.teams.new(team_params)
  	team.captain = current_user
  	team.save
    @tournament.users << current_user
  	redirect_to tournament_path(@tournament)
  end

  # Remove a team from a tournament
  # Remove team members from tournament
  # Remove team from tournament
  def destroy
    team = Team.find(params[:id])
    tournament = team.tournament
    team.users.each do |user|
      tournament.users.delete(user)
    end
    tournament.teams.delete(team)
    redirect_to tournament
  end

  private

  def team_params
  	params.require(:team).permit(:color_id, :tournament_id)
  end

end
