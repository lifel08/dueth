class ReviewsController < ApplicationController
  before_action :set_review, only: [:destroy, :edit]
  before_action :find_booking
  before_action :find_review, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = @booking.reviews.new(review_params)
    @review.instrument_id = @booking.instrument_id
    @review.user_id = @booking.user_id
    if @review.save
      redirect_to bookings_path, notice: 'Review succesfully saved!'
    else
      render "instruments/show"
    end
  end

  def edit


  end

  def update
    if @review.update(review_params)
      redirect_to instrument_path(@instrument)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    # possible in reference to the booking, not the instrument
    redirect_to instrument_path(@instrument)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

  def find_booking
    @booking = Booking.find(params[:booking_id])
  end

  def review
    @review = Review.find(params[:id])
  end
end
