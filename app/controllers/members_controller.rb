class MembersController < ApplicationController
  def index
    @members = User.order("created_at DESC").page;
		@endpoint = pagination_members_path
		@page_amount = @members.total_pages
  end

  def pagination
	   members = User.all.page(params[:page]);
	   render partial: 'members/member', layout: false, collection: members
	end
end
