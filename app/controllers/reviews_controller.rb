class ReviewsController < ApplicationController
  before_action :set_review, only: [:destroy, :edit]

  def create
    @booking = Booking.find(params[:booking_id])
    @instrument = Instrument.find(params[:instrument_id])
    @user = User.find(params[:user_id])
    @review = Review.new(review_params)
    @review.booking = @booking
    @review.instrument = @instrument
    @review.user = @user
    @review.review_instrument = 'instrument-review'
    if @review.save
      redirect_to user_profile_path(@booking.isntrument), anchor: "review-#{@review.id}", notice: 'Review succesfully saved!'
    else
      render "instruments/show"
    end
  end

  def edit
    @review.update(review_params)
    redirect_to user_profile_path(@instrument)
  end

  def destroy
    @review.destroy
    redirect_to user_profile_path(@review.instrument), notice: 'Review succesfully deleted!'
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
