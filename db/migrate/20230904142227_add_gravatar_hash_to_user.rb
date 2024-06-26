# frozen_string_literal: true

class AddGravatarHashToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :gravatar_hash, :string
  end
end
