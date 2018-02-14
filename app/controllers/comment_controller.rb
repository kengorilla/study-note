class CommentController < ApplicationController
    before_action :authenticate_user, {only: [:create, :destroy, :edit, :update]}
    before_action :ensure_correct_user, {only: [:update, :edit, :destroy]}
    
    
    def create
        @comment=Comment.new(content: params[:content], user_id: @current_user.id, 
        post_id: params[:id])
        if @comment.save
            redirect_to "/post/#{params[:id]}/show"
            flash[:notice]="You made comment on diary"
        else 
            redirect_to "/post/#{params[:id]}/show"
            flash[:notice]="Fail to save comment.Comment cannot be blanck and should be less than 100 characters"
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
            flash[:notice]="Editted comment!"
        else 
            redirect_to "/post/#{@comment.post_id}/show"
            flash[:notice]="Fail to edit comment.Comment cannot be blanck and should be less than 100 characters"
        end
    end
    
    def destroy
        @comment=Comment.find_by(id: params[:id])
        @comment.destroy
        redirect_to "/post/#{@comment.post_id}/show"
        flash[:notice]="Deleted comment"
    end    

    def ensure_correct_user
        @comment=Comment.find_by(id: params[:id])
        if @current_user.id != @comment.user_id
          flash[:notice]="You cannnot change others comment"
          redirect_to "/post/#{@comment.post_id}/show"
        end
    end
    
end