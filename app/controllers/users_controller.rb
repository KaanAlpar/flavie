class UsersController < ApplicationController
  include Pundit

  after_action :verify_authorized, only: [:dashboard]

  def show
    @conversion = Conversion.new
  end
end
