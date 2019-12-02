class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit]

  def root
  end

  def about
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.user = current_user
    if book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book
    else
      flash[:error] = book.errors.full_messages
      redirect_to books_path
    end
  end

  def show
    @book = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user_id
      redirect_to books_path
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "Book was successfully updated"
    else
      flash[:error] = book.errors.full_messages
    end
    redirect_to book_path
  end

  def destroy
    book = Book.find(params[:id])
    book.delete

    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end

