class BookingsController < ApplicationController
  before_action :set_instrument, only: [:new, :create]
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.instrument = @instrument
    @booking.user = current_user
    if @booking.save!
      redirect_to my_bookings_path
    else
      render :new
    end

  end

  def show
    @user = current_user
    @bookings = Booking.where(user: current_user)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to my_bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:date_start, :date_end)
  end

  def set_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end

end
