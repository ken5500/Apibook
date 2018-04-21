module V1
class BookcopiesController <
  before_action :set_book_copy, only: [:show, :destroy, :update]

    def index
      book_copies = BookCopy.preload(:book, :user, book: [:author]).paginate(page: params[:page])
      render json: book_copies, meta: pagination(book_copies), adapter: :json
    end

    def show
      render json: @book_copy, adapter: :json
    end

    def create
      book_copy = BookCopy.new(book_copy_params)
      if book_copy.save
        render json: book_copy, adapter: :json, status: 201
      else
        render json: { error: book_copy.errors }, status: 422
      end
    end

    def update
      if @book_copy.update(book_copy_params)
        render json: @book_copy, adapter: :json, status: 200
      else
        render json: { error: @book_copy.errors }, status: 422
      end
    end

    def destroy
      @book_copy.destroy
      head 204
    end

    private

    def set_book_copy
      @book_copy = BookCopy.find(params[:id])
    end

    def book_copy_params
      params.require(:book_copy).permit(:book_id, :format, :isbn, :published, :user_id)
    end
  end
end

module V1
  class BooksController < ApplicationController
    before_action :set_book, only: [:show, :destroy, :update]

    def index
      books = Book.preload(:author, :book_copies).paginate(page: params[:page])
      render json: books, meta: pagination(books), adapter: :json
    end

    def show
      render json: @book, adapter: :json
    end

    def create
      book = Book.new(book_params)
      if book.save
        render json: book, adapter: :json, status: 201
      else
        render json: { error: book.errors }, status: 422
      end
    end

    def update
      if @book.update(book_params)
        render json: @book, adapter: :json, status: 200
      else
        render json: { error: @book.errors }, status: 422
      end
    end

    def destroy
      @book.destroy
      head 204
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author_id)
    end
  end
end
