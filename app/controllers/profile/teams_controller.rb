class Profile::TeamsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def new
  	@team = Team.new
  end

  # Associate new team for a tournament
  # Associate the current user to tournament
  def create
    @tournament = Tournament.find(params[:tournament_id])
    team = @tournament.teams.new(team_params)
  	team.captain = current_user
  	team.save
    @tournament.users << current_user
  	redirect_to profile_teams_path
  end

  private

  def team_params
  	params.require(:team).permit(:color, :tournament_id)
  end

end
