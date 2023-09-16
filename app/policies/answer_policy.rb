class AnswerPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    !@user.guest_user?
  end

  def update?
    @user.author?(@record) || @user.admin_role? || @user.moderator_role?
  end

  def destroy?
    @user.author?(@record) || @user.admin_role? || @user.moderator_role?
  end
end