module V1
class UsersController < ApplicationController
  before_action :set_book, only: [:show, :destroy, :update]
  before_create :generate_api_key
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
