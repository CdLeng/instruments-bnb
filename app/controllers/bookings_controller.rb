class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index new]

  def index
    @bookings = policy_scope(Booking)
  end

  def new
    @booking = Booking.new
    @instrument = Instrument.find(params[:instrument_id])
    authorize(@booking)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.instrument = Instrument.find(params[:instrument_id])
    @booking.user = current_user
    authorize(@booking)
    if @booking.save!
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    @bookings = Booking.where(user: current_user)
  end

  def destroy
    @booking.destroy
    redirect_to booking_path, status: :see_other
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:date_start, :date_end)
  end

  def set_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end
end
