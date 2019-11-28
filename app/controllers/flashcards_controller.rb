class FlashcardsController < ApplicationController
  before_action :set_flashcard, only: [:update, :edit, :destroy, :get_translation]
  skip_after_action :verify_authorized, only: [:get_translation]

  def create
    @flashcard = Flashcard.new(flashcard_params)
    authorize @flashcard
  end

  def edit
    authorize @flashcard
    lang = @flashcard.sentence.conversion.language
    if lang == 'en'
      @words = @flashcard.sentence.content.split(' ')
    elsif lang == 'ja'
      ts = TinySegmenter.new
      @words = ts.segment(@flashcard.sentence.content, ignore_punctuation: true)
    end
  end

  def update
    authorize @flashcard
    if @flashcard.update(flashcard_params)
      redirect_to deck_path(@flashcard.deck)
    else
      render :edit
    end
  end

  def destroy
    authorize @flashcard
  end

  def get_translation
    @lang = @flashcard.sentence.conversion.language
    if @lang == 'en'
      @translation = FetchTranslationService.call_api(params[:translation][:keyword], 'en')
    else
      @translation = FetchTranslationService.call_api(params[:translation][:keyword], 'ja')
    end
    @word = params[:translation][:keyword]
  end

  private

  def set_flashcard
    @flashcard = Flashcard.find(params[:id])
  end

  def flashcard_params
    params.require(:flashcard).permit(:phrase_translation, sentence_attributes: [:content, :id])
  end
end
