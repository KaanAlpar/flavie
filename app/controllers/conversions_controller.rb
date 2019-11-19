require 'open-uri'

class ConversionsController < ApplicationController
  before_action :set_conversion, only: [:show]

  # https://www.youtube.com/watch?v=o_XVt5rdpFY
  def create
    # @conversion = Conversion.new(conversion_params)
    # @conversion.user = current_user
    url = params[:conversion][:url]
    params_new = { conversion: {
      url: url, sentences_attributes: fetch_api_get_sentences(url)
    } }
    @conversion = Conversion.new(params_new[:conversion])
    if @conversion.save
      authorize @conversion
      redirect_to conversion_path(@conversion)
    else
      render 'pages/home'
    end
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

  def fetch_api_get_sentences(conversion_url)
    video_id = conversion_url.last(11)
    url = "http://video.google.com/timedtext?lang=en&v=#{video_id}"
    doc = Nokogiri::XML(open(url)).text
    sentences = []

    if doc != ""
      doc.split('.').each do |sentence|
        sentences << { content: sentence }
      end
    else
      puts "This video does not have subtitles"
      raise
    end

    sentences
  end
end
