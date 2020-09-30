class BooksController < ApplicationController
  def index
    @newbook = Book.new
    @books = Book.all
  end

   def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book.id), notice: 'Book was successfully created.'
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
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id) ,notice: 'Book was successfully update
    d.'
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
end