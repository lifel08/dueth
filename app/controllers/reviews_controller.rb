class ReviewsController < ApplicationController
  before_action :find_review, only: [:destroy, :edit, :update]
  before_action :find_instrument, only: [:create, :edit]

  def new
    @review = Review.new
  end

  def create
    @review = @instrument.reviews.new(review_params)
    @review.user_id = @instrument.user_id
    if @review.save
      redirect_to user_client_bookings_path(current_user), notice: 'Review succesfully saved!'
    else
      render "instruments/show"
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to user_client_bookings_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to user_client_bookings_path(current_user)
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end

  def find_booking
    @booking = Booking.find(params[:booking_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def find_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end
end
