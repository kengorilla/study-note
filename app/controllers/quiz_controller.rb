class QuizController < ApplicationController
   before_action :authenticate_user
  
  def home
     @current_user_note=Note.where(user_id: @current_user.id).shuffle.first
  end
  
  def check
      @note = Note.find_by(id: params[:id])
    if params[:answer] == @note.korean
        flash[:notice]="correct"
        redirect_to "/quiz/home"
    else    
        flash[:notice]="incorrect"
        redirect_to "/quiz/home"
    end
  end
  
  
end
