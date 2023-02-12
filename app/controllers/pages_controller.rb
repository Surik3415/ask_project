class PagesController < ApplicationController
  def index
    @username = 'Suren'
    render 'pages/index'
  end
end
