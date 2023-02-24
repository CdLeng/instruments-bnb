class InstrumentCategoriesController < ApplicationController

  def index
    @categories = InstrumentCategory.all

  end

  def show
    @category = InstrumentCategory.find(params[:id])
    @all_instruments_category = Instrument.where(instrument_category: @category)
  end
end
