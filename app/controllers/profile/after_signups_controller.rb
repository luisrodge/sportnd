class Profile::AfterSignupsController < ApplicationController
  before_action :authenticate_member!
  layout 'full'

  def show
  end

  def update
    current_member.update_attributes(phone: params[:member][:phone])
    redirect_to root_path
  end
end
