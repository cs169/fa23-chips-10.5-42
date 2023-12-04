# frozen_string_literal: true

class AddRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.float :rating
      t.references :user_id, null: false
      t.references :news_item_id, null: false
      t.timestamps null: false
    end
  end
end
