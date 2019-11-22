class ConversionsController < ApplicationController
  before_action :set_conversion, only: [:show, :choose_deck]

  def create
    url = conversion_params[:video_id]
    begin
      video_id = CGI::parse(URI(url).query)["v"].first
      video_info = FetchVideoInfoService.call_api(video_id)
      @conversion = Conversion.find_or_create_by(video_id: video_id, user: current_user, video_title: video_info[:title]) do |conversion|
        sentences = FetchSentencesService.call_api(url, video_id)
        params_new = { conversion: {
          sentences_attributes: sentences.map { |sentence| { content: sentence } }
        } }

        conversion.assign_attributes(params_new[:conversion])
      end
    rescue Conversion::MissingSubtitlesError
      @conversion = Conversion.new
      @conversion.errors.add(:video_id, 'No subtitles avaliable for this video. Please try a different one.')
    rescue NoMethodError
      @conversion = Conversion.new(video_id: url)
      @conversion.errors.add(:video_id, 'Invalid information. URL could not be reached.')
    end

    authorize @conversion

    if @conversion.persisted?
      redirect_to conversion_path(@conversion)
    else
      @body_class = "home-page"
      render 'pages/home'
    end
  end

  def show
    authorize @conversion
  end

  private

  def conversion_params
    params.require(:conversion).permit(:video_id)
  end

  def set_conversion
    @conversion = Conversion.find(params[:id])
  end
end
