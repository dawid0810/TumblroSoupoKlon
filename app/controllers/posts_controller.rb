class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :quick_repost, :repost]
  before_action :require_permission, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order(id: :desc).paginate(:page => params[:page], :per_page => 10) if Post.any?
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def quick_repost
    post_to_dup = Post.find(params[:id])
    @post = post_to_dup.deep_clone :include => [ :notes, :images ] do |original, kopy|
      # filename = Rails.root.join('images', 'files', original.id.to_s.rjust(9, '0').scan(/.../).join('/'), 'original', kopy.file_file_name) if kopy.is_a?(Image)
      # kopy.file = File.new filename if kopy.is_a?(Image) and File.exists?(filename)
      kopy.file = original.file if kopy.is_a?(Image)
    end
    @post.post_id = post_to_dup.id
    @post.user_id = current_user.id
    @post.save
  end

  def repost
    quick_repost
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post, flash: { notice: "Success" }
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :post_id, :notes_attributes => [:id, :body, :_destroy, :order], :images_attributes => [:id, :file, :_destroy, :upload_file_name, :upload_content_type, :tempfile, :order, :caption, :source, :url, :np])
    end

    def require_permission
      if not (current_user and (current_user.admin? or @post.user_id == current_user.id))
        redirect_to root_path, flash: { alert: "Sorry, you are not allowed to do this" }
      end
    end
end
