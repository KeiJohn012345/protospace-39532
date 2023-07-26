class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :create]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to '/'
    else
      render :new
    end
  end

  def show
    # set_prototype
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    # set_prototype
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to @prototype # 投稿を編集した後に詳細画面にリダイレクトする場合
    else
      render :edit # バリデーションエラーがある場合は再度編集画面を表示
    end
  end

  def destroy
    @prototype.destroy
    redirect_to prototypes_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    if user_signed_in?
      if @prototype.blank? || @prototype.user == current_user
        # ログイン済みで、@prototypeがない（new, create）または
        # @prototypeの所有者が現在のユーザーである場合（edit, update, destroy）は何もしない
      else
        # ログイン済みだが@prototypeの所有者が現在のユーザーでない場合は、indexにリダイレクト
        redirect_to action: :index
      end
    else
      # ログインしていない場合は、indexにリダイレクト
      redirect_to action: :index
    end
  end
end