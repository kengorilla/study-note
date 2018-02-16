class QuizController < ApplicationController
   before_action :authenticate_user
  
  def home
     @current_user_note=Note.where(user_id: @current_user.id).shuffle.first
  end
  
  def check
      @note = Note.find_by(id: params[:id])
    if params[:answer].downcase == @note.korean.downcase
        flash[:notice]="Correct! Try next quiz!"
        redirect_to "/quiz/home"
    else    
        flash[:notice]="Incorrect"
        redirect_to "/quiz/#{@note.id}/answer"
    end
  end
  
  def answer
    @correct_answer = Note.find_by(id: params[:id])
  end
  
  def answer2
    @correct_answer = Note.find_by(id: params[:id])
  end
  
  def home2
    @current_user_note=Note.where(user_id: @current_user.id).shuffle.first
  end
  
  def check2
      @note = Note.find_by(id: params[:id])
    if params[:answer] == @note.japanese
        flash[:notice]="Correct! Try next quiz!"
        redirect_to "/quiz/japanese/home"
    else    
        flash[:notice]="Incorrect"
        redirect_to "/quiz/#{@note.id}/answer2"
    end
  end
  
end
