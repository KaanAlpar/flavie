class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @conversion = Conversion.new
    @body_class = "home-page"
  end
end
