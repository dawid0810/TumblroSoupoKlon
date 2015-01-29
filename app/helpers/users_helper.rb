module UsersHelper
  def can_follow
    current_user and current_user != @user and not @user.followed_by?(current_user)
  end
  def can_unfollow
    current_user and current_user != @user and @user.followed_by?(current_user)
  end
end
