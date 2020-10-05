class UsersController < ApplicationController
   # ログイン済ユーザーのみにアクセスを許可(ログインしてないと、ログイン画面へリダイレクト)
  before_action :authenticate_user!

  # private参照
  before_action :correct_user, only: [:edit, :update]

  def index
    @newbook = Book.new
    @users = User.all
  end

  def show
    @newbook = Book.new
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user), notice:'User was successfully updated.'
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  # ログインユーザ意外url入力で画面遷移できなくする（edit,updateを封じる）メソッド
  def correct_user
    user = User.find(params[:id])
  if current_user != user
    redirect_to user_path(current_user.id)
  end
  end

end
