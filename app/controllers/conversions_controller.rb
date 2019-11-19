class ConversionsController < ApplicationController
  def create
    authorize @conversion
  end

  def show
  end
end
