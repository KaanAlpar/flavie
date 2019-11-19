class ConversionsController < ApplicationController
  before_action :set_conversion, only: [:show]

  def create
    @conversion = Conversion.new(conversion_params)
    @conversion.user = current_user
    authorize @conversion
  end

  def show
    authorize @conversion
  end

  private

  def conversion_params
    params.require(:conversion).permit(:url)
  end

  def set_conversion
    @conversion = Conversion.find(params[:id])
  end
end
