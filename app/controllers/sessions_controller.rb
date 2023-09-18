# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :set_user, only: %i[create destroy]
  before_action :require_not_authentication, only: %i[create new]
  before_action :require_authentication, only: %i[destroy]

  def new; end

  # rubocop: disable Metrics/AbcSize

  def create
    if @user&.authenticate(params[:password])
      remember(@user) if params[:remember_token] == 1
      sing_in(@user)
      flash[:success] = "Welcome back, #{current_user.name_or_email}"
      redirect_to root_path
    else
      flash[:warning] = t '.invalid_creds'
      render :new
    end
  end
  # rubocop: enable Metrics/AbcSize

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find_by(email: params[:email])
  end
end
