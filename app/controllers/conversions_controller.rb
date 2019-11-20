class ConversionsController < ApplicationController
  before_action :set_conversion, only: [:show, :choose_deck]

  def create
    url = conversion_params[:url]
    c = Conversion.find_by(url: url, user: current_user)
    authorize c
    if c
      redirect_to conversion_path(c)
      return
    else
      sentences = FetchSentencesService.call_api(url)
      params_new = { conversion: {
        url: url, sentences_attributes: sentences.map { |sentence| { content: sentence } }
      } }

      @conversion = Conversion.new(params_new[:conversion])
      @conversion.user = current_user
      authorize @conversion
      if @conversion.save
        redirect_to conversion_path(@conversion)
      else
        render 'pages/home'
      end
    end
  end

  def show
    authorize @conversion
  end

  def choose_deck
    @deck = Deck.new
    @deck.flashcards.build
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
