# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_not_authentication, only: %i[create new]
  before_action :require_authentication, only: %i[edit update]
  before_action :set_user!, only: %i[edit update]

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      sing_in(@user)
      flash[:success] = "Welcome to app, #{current_user.name_or_email}"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @user&.update(user_params)
      flash[:success] = 'Your user info was updated!'
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_user!
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :old_password)
  end
end
