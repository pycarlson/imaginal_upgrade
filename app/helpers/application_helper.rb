module ApplicationHelper
  def video_path(video)

    if !video.id
      video = Video.find(video)
    end

    video_path = "/videos/#{video.id}/#{video.title.parameterize}"
  end
  def profile_path(profile)

    if !profile.id
      profile = Profile.find(profile)
    end

    profile_path = "/profiles/#{profile.id}/#{profile.user.name.parameterize}"
  end
end
