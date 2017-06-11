class MembersController < ApplicationController
  def index
    search = params[:q].present? ? params[:q] : nil
    @members = if search
      Kaminari.paginate_array(Member.search(search)).page
    else
      Member.order("created_at DESC").page;
    end

    #@members = User.order("created_at DESC").page;
		@endpoint = pagination_members_path
		@page_amount = @members.total_pages
  end

  def show
    @members = Member.find_by_hash_id!(params[:id])
  end

  def pagination
	  members = Member.order("created_at DESC").page(params[:page]);
	  render partial: 'members/member', layout: false, collection: members
	end
end
