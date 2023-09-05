# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @username = 'Suren'
    render 'pages/index'
  end
end
