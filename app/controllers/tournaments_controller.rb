class TournamentsController < ApplicationController
	before_action :notice_sidebar?

	def index
		search = params[:q].present? ? params[:q] : nil
		@tournaments = if search
      Kaminari.paginate_array(Tournament.search(search, where: {eowd_date: {"gte": "now/d"}})).page
    else
      Tournament.upcoming.page
    end

		#@tournaments = Tournament.upcoming.page
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

	private

	def notice_sidebar?
		@notice_sidebar = true
	end

end
