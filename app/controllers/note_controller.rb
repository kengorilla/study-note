class NoteController < ApplicationController
  before_action :authenticate_user,{only: [:new, :create, :index, :destroy, :edit, :update]}
  
  
  def new
    @note=Note.new
  end
  
  def create
    @note=Note.new(japanese:params[:japanese], korean:params[:korean], 
    example:params[:example], fq:params[:fq])
    if @note.save
      flash[:notice]="リストを追加しました。"
      redirect_to "/note/index"
    else 
      flash[:notice]="追加に失敗しました。"
      render "note/new"
    end
  end
  
  def index
    @list_count=Note.all.count
    
    if params[:od].blank? && params[:search].nil?
      @notes=Note.all.order(created_at: :desc)
    else
      if params[:od] == "使用頻度"
        @notes=Note.all.order(fq: :desc)
      else
        @notes=Note.all.order(created_at: :desc)
      end
      
      if params[:search]==""
      else
        if Note.where('japanese LIKE(?)', "<% #{params[:search]} %>")
          @search_results_jap=Note.where('japanese LIKE(?)', "%#{params[:search]}%")
        end
        if Note.where('korean LIKE(?)', "<% #{params[:search]} %>")
          @search_results_kor=Note.where('korean LIKE(?)', "%#{params[:search]}%")
        end
        if Note.where('example LIKE(?)', "<% #{params[:search]} %>")
          @search_results_exa=Note.where('example LIKE(?)', "%#{params[:search]}%")
        end
        @notes= @search_results_exa + @search_results_jap + @search_results_kor
      end
    end
  end
  
  def destroy
    @note=Note.find_by(id: params[:id])
    @note.destroy
    flash[:notice]="Listを消去しました"
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
      flash[:notice]="リストを編集しました"
      redirect_to("/note/index")
    else 
      flash[:notice]="編集に失敗しました"
      render "note/edit"
    end
  end

end
