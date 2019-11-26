class FlashcardsController < ApplicationController
  before_action :set_flashcard, only: [:update, :edit, :destroy]

  def create
    @flashcard = Flashcard.new(flashcard_params)
    authorize @flashcard
  end

  def edit
    authorize @flashcard
  end

  def update
    authorize @flashcard
  end

  def destroy
    authorize @flashcard
  end

  private

  def set_flashcard
    @flashcard = Flashcard.find(params[:id])
  end

  def flashcard_params
    params.require(:flashcard).permit(:sentence, :phrase_translation)
  end
end
