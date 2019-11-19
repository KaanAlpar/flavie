require 'open-uri'

class ConversionsController < ApplicationController
  before_action :set_conversion, only: [:show]

  # https://www.youtube.com/watch?v=o_XVt5rdpFY
  def create
    # @conversion = Conversion.new(conversion_params)
    # @conversion.user = current_user
    url = conversion_params[:url]
    params_new = { conversion: {
      url: url, sentences_attributes: GetSentences.fetch_api_get_sentences(url)
    } }

    # Dougs suggestion
    # params_new_2 = {conversion: conversion_params.merge(sentences_attributes: fetch_api_get_sentences(url))}

    @conversion = Conversion.new(params_new[:conversion])
    @conversion.user = current_user
    authorize @conversion
    if @conversion.save
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
end
