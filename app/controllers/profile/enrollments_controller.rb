class Profile::EnrollmentsController < ApplicationController
  def new
  	@tournament = Tournament.find(params[:tournament_id])
  end
  
end
