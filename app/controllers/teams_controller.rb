class TeamsController < ApplicationController
  def index
    @teams = Team.enrolled_in_tournaments.page;
		@endpoint = pagination_teams_path
		@page_amount = @teams.total_pages
  end

  def pagination
	   teams = Team.enrolled_in_tournaments.page(params[:page]);
	   render partial: 'teams/team', layout: false, collection: teams
	end
end
