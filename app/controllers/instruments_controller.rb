class InstrumentsController < ApplicationController
  before_action :set_instrument, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @instruments = policy_scope(Instrument)
  end

  def show
    authorize(@instrument)
  end

  def new
    @instrument = Instrument.new
  end

  def edit
  end

  def create
    @instrument = Instrument.new(instrument_params)
    @instrument.user = current_user

    if @instrument.save
      redirect_to @instrument, notice: "Instrument was succesfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @instrument.update(instrument_params)
      redirect_to @instrument, notice: "The instrument page has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @instrument.destroy
    redirect_to instruments_url, notice: "The instrument page has been removed."
  end

  private

  def set_instrument
    @instrument = Instrument.find(params[:id])

  end

  def instrument_params
    params.require(:instrument).permit(:name, :address, :price, :instrument_type, :description, :instrument_category)
  end
end
