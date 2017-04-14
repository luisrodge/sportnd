module TournamentsHelper

  def new_tournament_btn
    if current_user.start_new_tournament?
      link_to "New Tournament", new_profile_tournament_path, class: "btn btn-primary round"
    end
  end

end
