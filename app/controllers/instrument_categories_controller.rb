class InstrumentCategoriesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @categories = InstrumentCategory.all
    @categories = policy_scope(InstrumentCategory)
  end

  def show
    @category = InstrumentCategory.find(params[:id])
    @all_instruments_category = Instrument.where(instrument_category: @category)
    authorize @all_instruments_category
    authorize @category
  end
end
