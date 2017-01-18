module FlagHelper
  def restricted_status(flag)
    (flag.restrict_to_editors) ? 'Yes': 'No'
  end

  def can_view_flag?(flag)
    (flag.restrict_to_editors == false) || (can? :view, flag)
  end

  def link_to_with_icon(icon_css, on_text, display_text, url, options = {})
    icon = content_tag(:span, nil, class: icon_css) + " #{display_text}"
    options[:title] = on_text
    link_to(icon, url, options)
  end

  def toggle_button_to(flag, url_params, options = {})
    on_options = {
      'data-remote' => true,
      'data-type' => 'script',
      'data-method' => 'POST',
      class: options[:on]
    }

    off_options = {
      'data-remote' => true,
      'data-type' => 'script',
      'data-method' => 'DELETE',
      class: options[:off]
    }

    on_link  = link_to_with_icon(flag.on_css, flag.on_text, flag.on_text_display, create_flag_vote_path(url_params), on_options)
    off_link = link_to_with_icon(flag.off_css, flag.off_text, flag.off_text_display, destroy_flag_vote_path(url_params), off_options)

    on_link << off_link
  end

  def current_user_id
    (!current_user.nil?) ? current_user.id : nil
  end

  def url_params(flag_vote, delta)
    {flag_vote: {user_id: flag_vote.user_id, record_id: flag_vote.record_id, flag_id: flag_vote.flag_id, delta: delta}}
  end

    # if user is logged in, return current_user, else return guest_user
  def current_or_guest_or_anonymous_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in(session[:guest_user_id])
        guest_or_anonymous_user.try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_or_anonymous_user
    end
  end

  def logging_in(guest_user_id)
    # Migrate guest flags to authenticated user flags
    FlagVote.where("user_id = ?", guest_user_id).update_all(:user_id => current_user.id)
  end

  def guest_or_anonymous_user
    @cached_guest_user ||= User.find(session[:guest_user_id])
  rescue ActiveRecord::RecordNotFound
    session[:guest_user_id] = nil
    User.new
  end

  def flagged_by_users(document_id)
    flagged = []
    FlagVote.by_record(document_id).each do |flag_vote|
      unless current_or_guest_or_anonymous_user.id == flag_vote.user_id
        user = User.find(flag_vote.user_id)
        flagged << {user: user, flag: flag_vote.flag, flag_vote: flag_vote}
      end
    end
    flagged.uniq
  end
end
