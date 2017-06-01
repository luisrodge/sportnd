class MembersController < ApplicationController
  def index
    search = params[:q].present? ? params[:q] : nil
    @members = if search
      Kaminari.paginate_array(User.search(search)).page
    else
      User.order("created_at DESC").page;
    end

    #@members = User.order("created_at DESC").page;
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
