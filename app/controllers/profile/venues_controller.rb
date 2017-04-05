class Profile::VenuesController < ApplicationController
  def new
  end

  def create
  	Venue.create(venue_params)
  	redirect_to root_path
  end

  private

  def venue_params
  	params.require(:venue).permit(:name, :venue_image, :address)
  end

end
