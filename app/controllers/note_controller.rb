class NoteController < ApplicationController
  before_action :authenticate_user,{only: [:new, :create, :index, :destroy, :edit, :update]}
  before_action :ensure_correct_user,{only: [:edit, :destroy, :update]}
  
  
  def new
    @note=Note.new
  end
  
  def create
    @note=Note.new(japanese:params[:japanese], korean:params[:korean], 
    example:params[:example], fq:params[:fq], user_id: @current_user.id)
    if @note.save
      flash[:notice]="Add words"
      redirect_to "/note/index"
    else 
      flash[:notice]="Fail to add words"
      render "note/new"
    end
  end
  
  def index
    @current_user_notes=Note.where(user_id: @current_user.id)
    @list_count=@current_user_notes.count
    
    if params[:od].blank? && params[:search].nil?
      @notes=@current_user_notes.all.order(created_at: :desc)
    else
      if params[:od] == "Most frequent"
        @notes=@current_user_notes.all.order(fq: :desc)
      else
        @notes=@current_user_notes.all.order(created_at: :desc)
      end
      
      if params[:search]==""
      else
        if @current_user_notes.where('japanese LIKE(?)', "<% #{params[:search]} %>")
          @search_results_jap=@current_user_notes.where('japanese LIKE(?)', "%#{params[:search]}%")
        end
        if @current_user_notes.where('korean LIKE(?)', "<% #{params[:search]} %>")
          @search_results_kor=@current_user_notes.where('korean LIKE(?)', "%#{params[:search]}%")
        end
        @notes= @search_results_jap + @search_results_kor
      end
    end
  end
  
  def destroy
    @note=Note.find_by(id: params[:id])
    @note.destroy
    flash[:notice]="Deleted word"
    redirect_to("/note/index")
  end
  
  def edit
    @note=Note.find_by(id: params[:id])
  end
  
  def update
    @note=Note.find_by(id: params[:id])
    @note.japanese=params[:japanese]
    @note.korean=params[:korean]
    @note.example=params[:example]
    @note.fq=params[:fq]
    if @note.save
      flash[:notice]="Editted the word"
      redirect_to("/note/index")
    else 
      flash[:notice]="Fail to edit the word"
      render "note/edit"
    end
  end
  
   def ensure_correct_user
        @note=Note.find_by(id: params[:id])
        if @current_user.id != @note.user_id
          flash[:notice]="You cannot others words"
          redirect_to "/note/index"
        end
   end

end
