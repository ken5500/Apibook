module V1
class BookcopiesController <
  class BookCopiesController < ApplicationController
    skip_before_action :authenticate_admin, only: [:return_book, :borrow]
    before_action :authenticate, only: [:return_book, :borrow]
    before_action :current_user_presence, only: [:return_book, :borrow]
    before_action :set_book_copy, only: [:show, :destroy, :update, :borrow, :return_book]


    def borrow
      if @book_copy.borrow(current_user)
        render json: @book_copy, adapter: :json, status: 200
      else
        render json: { error: 'Cannot borrow this book.' }, status: 422
      end
    end

    def return_book
      authorize(@book_copy)

      if @book_copy.return_book(current_user)
        render json: @book_copy, adapter: :json, status: 200
      else
        render json: { error: 'Cannot return this book.' }, status: 422
      end
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
