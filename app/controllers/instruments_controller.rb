class InstrumentsController < ApplicationController
  before_action :set_instrument, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show my_instruments]

  def index
    @instruments = policy_scope(Instrument.where.not(user: current_user))
  end

  def my_instruments
    @instruments = current_user.instruments
    authorize(@instruments)
  end

  def show
    authorize(@instrument)
  end

  def new
    @instrument = Instrument.new
    authorize(@instrument)
  end

  def edit
    authorize(@instrument)
  end

  def create
    @instrument_category = InstrumentCategory.find(instrument_params[:instrument_category_id])
    @instrument = Instrument.new(instrument_params)
    @instrument.user = current_user
    @instrument.instrument_category = @instrument_category
    authorize(@instrument)

    if @instrument.save
      redirect_to instrument_path(@instrument), notice: "Instrument was succesfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize(@instrument)
    if @instrument.update(instrument_params)
      redirect_to @instrument, notice: "The instrument page has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@instrument)
    @instrument.destroy
    redirect_to instruments_url, notice: "The instrument page has been removed."
  end

  private

  def set_instrument
    @instrument = Instrument.find(params[:id])

  end

  def instrument_params
    params.require(:instrument).permit(:name, :address, :price, :description, :instrument_category_id)
  end
end
