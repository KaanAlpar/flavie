class ConversionsController < ApplicationController
  before_action :set_conversion, only: [:show, :choose_deck]

  def create
    url = conversion_params[:url]
    video_id = CGI::parse(URI(url).query)["v"].first

    begin
      @conversion = Conversion.find_or_create_by(url: video_id, user: current_user) do |conversion|
        sentences = FetchSentencesService.call_api(url)
        params_new = { conversion: {
          sentences_attributes: sentences.map { |sentence| { content: sentence } }
        } }

        conversion.assign_attributes(params_new[:conversion])
      end
    rescue Conversion::MissingSubtitlesError
      @conversion = Conversion.new
      @conversion.errors.add(:url, 'is bad. No subtitles avaliable for this video. Please try a different one.')
    end

    authorize @conversion

    if @conversion.persisted?
      redirect_to conversion_path(@conversion)
    else
      render 'pages/home'
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
