class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @bookings = policy_scope(Booking)
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.save
    redirect_to my_bookings_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to instruments_path, status: :see_other
  end

  def show
    @user = current_user
    @bookings = Booking.where(user: @user)
  end

  private

  def booking_params
    params.require(:booking).permit(:date_start, :date_end)
  end

end
