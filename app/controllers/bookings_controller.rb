class BookingsController < ApplicationController

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.save
    redirect_to instruments_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to instruments_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:date_start, :date_end)
  end

end
