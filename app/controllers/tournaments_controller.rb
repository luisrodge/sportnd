class TournamentsController < ApplicationController
	layout "secondary", except: :show

	def index
		@tournaments = Tournament.upcoming.order("created_at DESC").page;
		@endpoint = pagination_tournaments_path
		@page_amount = @tournaments.total_pages
	end

	def show
		@tournament = Tournament.find_by_hash_id!(params[:id])
	end

	def pagination
	    tournaments = Tournament.all.page(params[:page]);
	    render partial: 'tournaments/item', layout: false, collection: tournaments
	end

end
