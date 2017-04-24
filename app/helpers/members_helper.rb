module MembersHelper
  def tournaments_tracker_txt(member)
    if member.tournaments.any?
      if member.tournaments_this_week.any?
        content_tag :h4, "#{pluralize(member.tournaments.upcoming.count, 'tournament')}, #{member.tournaments_this_week.count} this week"
      else
        content_tag :h4, pluralize(member.tournaments.upcoming.count, "tournament")
      end
    else
      content_tag :h4, "No tournaments yet"
    end
  end
end
