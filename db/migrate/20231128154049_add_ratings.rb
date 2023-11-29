class AddRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.float :rating, null: false
      t.belongs_to :user
      t.belongs_to :news_items
    end
  end
end
