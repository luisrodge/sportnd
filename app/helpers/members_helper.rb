module MembersHelper

  def member_tournaments_count(member)
    if member.tournaments.any?
      if member.tournaments_this_week.any?
        content_tag :h4, "#{pluralize(member.tournaments.upcoming.count, 'tournament')}, #{member.tournaments_this_week.count} this weekend"
      else
        content_tag :h4, pluralize(member.tournaments.upcoming.count, "tournament")
      end
    else
      content_tag :h4, "No tournaments yet"
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
