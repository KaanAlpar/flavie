class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :practice]
  skip_after_action :verify_authorized, only: [:choose_deck]

  def index
    @decks = policy_scope(Deck).where(user: current_user)
    @deck = Deck.new
  end

  def show
    authorize @deck

    sentence_ids = session[:sentence_ids]
    unless sentence_ids.nil?
      sentence_ids.each do |sentence_id|
        Flashcard.create!(sentence_id: sentence_id, deck: @deck)
      end
      session.delete(:sentence_ids)
    end
  end

  def create
    new_params = deck_params
    unless session[:sentence_ids].nil?
      new_params = deck_params.merge(flashcards_attributes: session[:sentence_ids].map { |sentence_id| { sentence_id: sentence_id } })
    end
    @deck = Deck.new(new_params.merge(user: current_user))
    authorize @deck
    if @deck.save
      session.delete(:sentence_ids)
      redirect_to deck_path(@deck)
    else
      render :new
    end
  end

  def practice
    authorize @deck
  end

  def choose_deck
    session[:sentence_ids] = params[:sentence_ids]
    redirect_to decks_path
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name)
  end
end
