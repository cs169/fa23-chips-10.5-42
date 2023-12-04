class FixRatingsCols < ActiveRecord::Migration[5.2]
  def change
    rename_column :ratings, :user_id_id, :user_id
    rename_column :ratings, :news_item_id_id, :news_item_id
  end
end
