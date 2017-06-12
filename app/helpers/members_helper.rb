module MembersHelper

  def days_balling_on(member)
    if member.upcoming_tournaments.any?
      if member.upcoming_tournaments.count > 1
        "Balling on #{member.upcoming_tournaments.first.date} and #{member.upcoming_tournaments.last.date}"
        capture do
          concat "Balling on "
          concat link_to("#{member.upcoming_tournaments.first.date.strftime("%A")}", tournament_path(member.tournament_this_date(member.upcoming_tournaments.first)), class: "notice")
          concat " and "
          concat link_to("#{member.upcoming_tournaments.last.date.strftime("%A")}", tournament_path(member.tournament_this_date(member.upcoming_tournaments.last)), class: "notice")
        end
      else
        capture do
          concat "Balling on "
          concat link_to("#{member.upcoming_tournaments.first.date.strftime("%A")}", tournament_path(member.tournament_this_date(member.upcoming_tournaments.first)), class: "notice")
        end
      end
    else
      "No tournaments"
    end
  end

  def profile_image(member)
    image_tag(member.image + "?width=100&height=100", class: "img-circle", alt: "#{member.name}")
  end

  def profile_image_md(member)
    image_tag(member.image + "?width=180&height=180", class: "img-circle", alt: "#{member.name}")
  end

  def tournament_profile_img(member)
    image_tag(member.image + "?width=110&height=110", class: "img-circle default")
  end

  def first_name(member)
    member.name.split(" ").first
  end

end
