class PostSerializer

  def initialize(posts:, user:)
    @posts = posts
    @user = user
    @serialized_user = UserSerializer.new(user: user).serialize()
  end

  def serialize_with_user_as_json
    serialize_with_user.to_json()
  end

  def serialize_with_user
    serialize().merge({ user: @serialized_user })
  end

  def serialize_as_json
    serialize().to_json()
  end
  
  def serialize
    posts_key = get_posts_key()
    { posts_key => serialize_each_post() }
  end

  private def get_posts_key
    is_feed?() ? :posts : :post
  end

  private def serialize_each_post
    if is_feed?()
      @posts.map() { |post| serialize_post(post) }
    else
      serialize_post(@posts)
    end
  end

  private def is_feed?
    @posts.is_a?(ActiveRecord::AssociationRelation)
  end

  private def serialize_post(post)
    {
      id: post.id,
      image_url: post.get_image_url(),
      caption: post.caption,
      most_recent_likes: post.get_most_recent_likes(),
      like_count: post.likes.length,
      created_at: post.created_at,
      liked_by_current_user: post.liked_by?(@user),
      author: {
        id: post.user.id,
        username: post.user.username,
        avatar: post.user.get_avatar_url(),
        followed_by_current_user: post.user.followed_by?(@user)
      }
    }
  end

end