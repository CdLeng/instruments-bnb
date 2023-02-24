class ReviewsController < ApplicationController
  before_action :set_instrument, only: %i[new create]

  def new
    @instrument = Instrument.find(params[:instrument_id])
    @review = Review.new
  end

  def create
    @review.user = current_user
    @review = Review.new(review_params)
    @review.instrument = @instrument
    @review.save
    redirect_to instrument_path(set_instrument)
  end

  private

  def set_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end

  def review_params
    params.require(:review).permit(:content, :rate)
  end

end
