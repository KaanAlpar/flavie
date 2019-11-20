class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :practice]

  def index
    @decks = policy_scope(Deck).where(user: current_user)
  end

  def show
    authorize @deck
    return unless params[:deck][:flashcards_attributes]

    params = deck_params.to_hash
    params["flashcards_attributes"].each do |arr|
      fc = Flashcard.new(sentence: Sentence.find(arr.second["sentence_id"]), deck: @deck)
      raise unless fc.save
    end
  end

  def new
    @deck = Deck.new
    authorize @deck
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user = current_user
    authorize @deck
    if @deck.save
      redirect_to deck_path(@deck)
    else
      render :new
    end
  end

  def practice
    authorize @deck
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name, flashcards_attributes: [:sentence_id])
  end
end
