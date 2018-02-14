class PostController < ApplicationController
before_action :authenticate_user,{only: [:new, :create, :index, :update, :destroy, :show]}
before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}

  def new
    @post=Post.new
  end
  
  def create
    @post=Post.new(title: params[:title], content: params[:content],
    user_id: @current_user.id)
    if @post.save
      flash[:notice]="Added diary"
      redirect_to("/post/index")
    else 
      flash[:notice]="Fail to add diary"
      render "post/new"
    end
  end
  
  def index
    @post_count=Post.all.count
    @posts=Post.all
  end
  
  def edit
    @post=Post.find_by(id: params[:id])
  end

  def update
    @post=Post.find_by(id: params[:id])
    @post.title=params[:title]
    @post.content=params[:content]
    if @post.save
      flash[:notice]="Editted the diary"
      redirect_to("/post/index")
    else 
      flash[:notice]="Fail to edit the diary"
      render "post/edit"
    end
  end
  
  def destroy
    @post=Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]="Deleted diary"
    redirect_to "/post/index"
  end
  
  def show
    @post=Post.find_by(id: params[:id])
    @comments=Comment.where(post_id: params[:id])
  end
  
  def ensure_correct_user
    @post=Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice]="You cannot change others diary"
      redirect_to("/post/index")
    end
  end
end
