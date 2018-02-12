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
      flash[:notice]="日記を追加しました"
      redirect_to("/post/index")
    else 
      flash[:notice]="保存に失敗しました"
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
      flash[:notice]="日記を編集しました"
      redirect_to("/post/index")
    else 
      flash[:notice]="保存に失敗しました"
      render "post/edit"
    end
  end
  
  def destroy
    @post=Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]="日記を削除しました"
    redirect_to "/post/index"
  end
  
  def show
    @post=Post.find_by(id: params[:id])
    @comments=Comment.where(post_id: params[:id])
  end
  
  def ensure_correct_user
    @post=Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice]="ほかの人の日記は、変更できません"
      redirect_to("/post/index")
    end
  end
end
