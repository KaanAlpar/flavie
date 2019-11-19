class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :practice]

  def index
    @decks = policy_scope(Deck).where(user: current_user)
  end

  def show
    authorize @deck
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
