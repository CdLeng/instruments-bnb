class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index new]

  def index
    @bookings = policy_scope(Booking)
  end

  def new
    @booking = Booking.new
    authorize(@booking)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    authorize(@booking)
    @booking.save
    redirect_to my_bookings_path
  end

  def destroy
    @booking.destroy
    redirect_to instruments_path, status: :see_other
  end

  def show
    @user = current_user
    @bookings = Booking.where(user: @user)
  end

  private

  def set_booking
    @instrument = Instrument.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:date_start, :date_end)
  end
end
