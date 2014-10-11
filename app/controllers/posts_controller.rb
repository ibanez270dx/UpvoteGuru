class PostsController < ApplicationController

  def index
    @posts = Post.all.order(upvotes: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new params.require(:post).permit(:name, :url)

    if @post.save
      flash[:notice] = "Post added successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def upvote
    post = Post.find params[:id]
    post.upvotes += 1
    post.save

    flash[:notice] = "Upvoted successfully!"
    redirect_to root_path
  end

end
