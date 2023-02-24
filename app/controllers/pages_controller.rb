class PagesController < ApplicationController
  def home
    @categories = InstrumentCategory.all
  end
end
