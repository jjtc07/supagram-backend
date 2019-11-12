class FollowSerializer

  def initialize(follow)
    @follow = follow
  end

  def serialize_follow
    {
      user: {
        id: @follow.followed_id,
        username: @follow.followed.username,
        followed_by_current_user: true
      }
    }.to_json()
  end

  def serialize_unfollow
    {
      user: {
        id: @follow.followed_id,
        username: @follow.followed.username,
        followed_by_current_user: false
      }
    }.to_json()
  end

end