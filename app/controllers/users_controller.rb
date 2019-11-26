class UsersController < ApplicationController
  include Pundit

  after_action :verify_authorized, only: [:dashboard]

  def show
    @conversion = Conversion.new
    @decks = current_user.decks.order("lower(name) ASC")
  end
end
