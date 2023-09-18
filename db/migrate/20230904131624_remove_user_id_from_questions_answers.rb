# frozen_string_literal: true

class RemoveUserIdFromQuestionsAnswers < ActiveRecord::Migration[7.0]
  def up
    change_colum_default :questions, :user_id, from: User.id, to: nil
    change_colum_default :answers, :user_id, from: User.id, to: nil
  end

  def down
    change_colum_default :questions, :user_id, from: nil, to: User.id
    change_colum_default :answers, :user_id, from: nil, to: User.id
  end
end
