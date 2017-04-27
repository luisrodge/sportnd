class MembersController < ApplicationController
  def index
    @members = User.order("created_at DESC").page;
		@endpoint = pagination_members_path
		@page_amount = @members.total_pages
  end

  def show
    @user = User.find_by_hash_id!(params[:id])
  end

  def pagination
	  members = User.order("created_at DESC").page(params[:page]);
	  render partial: 'members/member', layout: false, collection: members
	end
end
