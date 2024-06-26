# frozen_string_literal: true

class AnswersController < ApplicationController
  include ActionView::RecordIdentifier
  include Authorization

  before_action :set_question
  before_action :set_answer, only: %i[destroy edit update]
  before_action :authorize_controller!

  def edit; end

  def create
    @answer = @question.answers.build(answer_create_params).decorate

    if @answer.save
      flash[:success] = t '.success'
      redirect_to question_path(@question)
    else
      @answers = Answer.includes(:user).order created_at: :desc
      render 'questions/show'
    end
  end

  def update
    if @answer&.update answer_update_params
      flash[:success] = t '.success'
      redirect_to question_path(@question, anchor: "answer-#{@answer.id}")
    else
      @answers = @question.decorate.answers.order created_at: :desc
      render :edit
    end
  end

  def destroy
    if @answer&.destroy
      flash[:success] = t '.success'
      redirect_to question_path(@question)
    else
      @answers = @question.answers.order created_at: :desc
      render 'questions/show'
    end
  end

  private

  def authorize_controller!
    authorize(@answer || Answer)
  end

  def set_question
    @question = Question.find params[:question_id]
  end

  def set_answer
    @answer = @question.answers.find params[:id]
  end

  def answer_create_params
    user = current_user.decorate
    params.require(:answer).permit(:body).merge(user: user)
  end

  def answer_update_params
    params.require(:answer).permit(:body)
  end
end
