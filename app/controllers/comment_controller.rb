class CommentController < ApplicationController
    before_action :authenticate_user, {only: [:create, :destroy, :edit, :update]}
    before_action :ensure_correct_user, {only: [:update, :edit, :destroy]}
    
    
    def create
        @comment=Comment.new(content: params[:content], user_id: @current_user.id, 
        post_id: params[:id])
        if @comment.save
            redirect_to "/post/#{params[:id]}/show"
            flash[:notice]="日記にコメントしました"
        else 
            redirect_to "/post/#{params[:id]}/show"
            flash[:notice]="コメントの保存に失敗しました。コメントは空白、100文字以上は反映されません"
        end
    end
    
    def edit
        @comment=Comment.find_by(id: params[:id])
        @post=Post.find_by(id: @comment.post_id)
    end
    
    def update
        @comment=Comment.find_by(id: params[:id])
        @comment.content= params[:content]
        if @comment.save
            redirect_to "/post/#{@comment.post_id}/show"
            flash[:notice]="コメントを編集しました"
        else 
            redirect_to "/post/#{@comment.post_id}/show"
            flash[:notice]="コメントの編集に失敗しました。コメントは空白、100文字以上は反映されません"
        end
    end
    
    def destroy
        @comment=Comment.find_by(id: params[:id])
        @comment.destroy
        redirect_to "/post/#{@comment.post_id}/show"
        flash[:notice]="コメントを消しました"
    end    

    def ensure_correct_user
        @comment=Comment.find_by(id: params[:id])
        if @current_user.id != @comment.user_id
          flash[:notice]="ほかの人のコメントは、変更できません"
          redirect_to "/post/#{@comment.post_id}/show"
        end
    end
    
end