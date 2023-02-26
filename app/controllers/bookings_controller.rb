class BookingsController < ApplicationController
  before_action :set_booking, only: %i[edit update destroy]
  skip_before_action :authenticate_user!, only: %i[new]

  def all
    @user = current_user
    @bookings = Booking.where(user: current_user)
    authorize(@bookings)
  end

  def show
    authorize(@booking)
  end

  def edit
    authorize(@booking)
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
      redirect_to my_bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@booking)
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    if @booking.update(booking_params)
      redirect_to my_bookings_path, notice: "The booking has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to booking_path, status: :see_other
    authorize(@booking)
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:date_start, :date_end, :id)
  end

  def set_instrument
    @instrument = Instrument.find(params[:instrument_id])
  end
end
