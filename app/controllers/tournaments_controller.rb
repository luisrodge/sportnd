class TournamentsController < ApplicationController

	def index
		@tournaments = Tournament.upcoming.page
		@endpoint = pagination_tournaments_path
		@page_amount = @tournaments.total_pages
	end

	def show
		@tournament = Tournament.find_by_hash_id!(params[:id])
	end

	def pagination
	    tournaments = Tournament.upcoming.page(params[:page])
	    render partial: 'tournaments/tournament', layout: false, collection: tournaments
	end

end
