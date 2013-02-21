class TopicDecorator < Draper::Decorator
  delegate_all

  def topic_link
    h.link_to source.title, source
  end

  def submitter_link
    h.link_to source.submitter.username, h.user_path(source.submitter)
  end

  def speaker_link
    if h.signed_in?
      user_speaker_link
    else
      anonymous_speaker_link
    end
  end

  def description
    h.truncate(source.description, length: 30)
  end

  private

  def user_speaker_link
    if source.speaker_id == h.current_user.id
      h.link_to 'Unclaim', h.unclaim_topic_path(source), method: :put
    elsif source.speaker_id.present?
      h.link_to source.speaker.username, h.user_path(source.speaker)
    elsif source.claimable?
      h.link_to 'Claim', h.claim_topic_path(source), method: :put
    end
  end

  def anonymous_speaker_link
    if source.speaker.present?
      h.link_to source.speaker.username, h.user_path(source.speaker)
    end
  end

end
