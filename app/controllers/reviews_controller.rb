class ReviewsController < ApplicationController
  before_action :set_review, only: [:destroy, :edit]
  before_action :find_instrument

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.instrument_id = @instrument.id
    @review.user_id = current_user.id
    if @review.save
      redirect_to instrument_path(@instrument), notice: 'Review succesfully saved!'
    else
      render "instruments/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

  def find_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end
end
