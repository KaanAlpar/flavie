class FlashcardsController < ApplicationController
  before_action :set_flashcard, only: [:update, :edit, :destroy]
  skip_after_action :verify_authorized, only: [:get_translation]

  def create
    @flashcard = Flashcard.new(flashcard_params)
    authorize @flashcard
  end

  def edit
    authorize @flashcard
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
    @translation = FetchTranslationService.call_api(params[:translation][:keyword], 'en')
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
