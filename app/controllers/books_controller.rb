class BooksController < ApplicationController
 # ログイン済ユーザーのみにアクセスを許可(ログインしてないと、ログイン画面へリダイレクト)
  before_action :authenticate_user!

  # private参照
  before_action :correct_user, only: [:edit, :update]

  def index
    @newbook = Book.new
    @books = Book.all
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
      redirect_to book_path(@newbook.id) ,notice: 'Book was successfully create
      d.'
    else
      @books = Book.all
      render 'index'
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
  if
    @book.update(book_params)
    redirect_to book_path(@book.id) ,notice: 'Book was successfully updated.'
  else
    render 'edit'
  end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path , notice: 'Book was successfully destroyed.'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  # ログインユーザ意外url入力で画面遷移できなくする（edit,updateを封じる）メソッド
  def correct_user
     book = Book.find(params[:id])
  if current_user.id != book.user.id
       redirect_to books_path
  end
  end

end
