class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  def top
  end

  def about
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'successfully created'
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render action: :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new 
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def edit
    if current_user == Book.find(params[:id]).user
      @book = Book.find(params[:id])
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'successfully updated'
    else 
      render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path, notice: 'successfully deleted'
    else
      render action: :index
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
