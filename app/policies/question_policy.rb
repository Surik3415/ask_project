class QuestionPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    @user.author?(@record) || @user.admin_role? || @user.moderator_role?
  end

  def destroy?
    @user.author?(@record) || @user.admin_role? || @user.moderator_role?
  end
end