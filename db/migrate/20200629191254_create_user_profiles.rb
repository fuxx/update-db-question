# frozen_string_literal: true

class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.string :display_name
      t.string :field_a
      t.string :field_b

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
