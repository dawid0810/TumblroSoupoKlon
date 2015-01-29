class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followed, :followers]
  def show
  end

  def follow
    user_to_follow = User.find(params[:id])
    current_user.follow(user_to_follow) if current_user and current_user != user_to_follow
    redirect_to request.referer
  end

  def unfollow
    user_to_unfollow = User.find(params[:id])
    current_user.stop_following(user_to_unfollow) if current_user and current_user != user_to_unfollow
    redirect_to request.referer
  end

  def followed
    get_followed_users_posts
  end

  def followers
    get_followers_posts
  end

  private
    def set_user
      @user = current_user if current_user
      @user = User.where("username = ?", params[:username]).first if params[:username].present?
    end
    def get_followed_users_posts
      @user.all_following.each do |f|
        @posts ||= f.posts
      end
    end
    def get_followers_posts
      @user.followers.each do |f|
        @posts ||= f.posts
      end
    end
end
