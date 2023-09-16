# frozen_string_literal: true

class QuestionsController < ApplicationController
  include Authorization
  before_action :set_question, only: %i[show destroy edit update]
  before_action :authorize_controller!

  def index
    @pagy, @questions = pagy Question.includes(:user).order(created_at: :desc)
    @questions = @questions.decorate
  end

  def show
    @question = @question.decorate
    @answer = @question.answers.build
    @pagy, @answers = pagy @question.answers.includes(:user).order(created_at: :desc).decorate
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = current_user.questions.build(question_params).decorate
    if @question.save
      flash[:success] = 'Question created'
      redirect_to questions_path
    else
      render :new
    end
  end

  def update
    if @question.update question_params
      flash[:success] = 'Question updated'
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = 'Question deleted'
    redirect_to questions_path
  end

  private

  def authorize_controller!
    authorize(@question || Question)
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find params[:id]
  end
end
