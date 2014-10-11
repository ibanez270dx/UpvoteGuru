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
    session[:voted_on] ||= []

    if session[:voted_on].include?(params[:id])
      flash[:notice] = "You can't vote more than once on the same post ;)"
    else
      post = Post.find params[:id]
      post.upvotes += 1
      post.save

      session[:voted_on] << params[:id]
      flash[:notice] = "Upvoted successfully!"
    end
    redirect_to root_path
  end

end
