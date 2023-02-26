class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    @categories = InstrumentCategory.all
    @instruments = Instrument.all
  end
end
