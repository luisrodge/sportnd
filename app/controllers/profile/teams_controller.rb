class Profile::TeamsController < ApplicationController
  before_action :authenticate_member!

  def new
  	@team = Team.new
  end

  # Associate new team for a tournament
  # Associate the current member to tournament
  def create
    @tournament = Tournament.find_by_hash_id!(params[:tournament_id])
    team = @tournament.teams.new(team_params)
  	team.captain = current_member
  	team.save
    @tournament.members << current_member
  	redirect_to tournament_path(@tournament)
  end

  # Remove a team from a tournament
  # Remove team members from tournament
  # Remove team from tournament
  def destroy
    team = Team.find(params[:id])
    tournament = team.tournament
    team.members.each do |member|
      tournament.members.delete(member)
    end
    tournament.teams.delete(team)
    redirect_to tournament
  end

  private

  def team_params
  	params.require(:team).permit(:color_id, :tournament_id)
  end

end
