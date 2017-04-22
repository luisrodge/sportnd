class TeamsController < ApplicationController
  def index
    @teams = Team.page;
		@endpoint = pagination_teams_path
		@page_amount = @teams.total_pages
  end

  def pagination
	   teams = Team.all.page(params[:page]);
	   render partial: 'teams/team', layout: false, collection: teams
	end
end
