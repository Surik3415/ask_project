# frozen_string_literal: true

class AddRoleToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, default: 0, null: false
    add_index :users, :role
  end
end
