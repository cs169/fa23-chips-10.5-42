class FixBelongsToUsersInRatings < ActiveRecord::Migration[5.2]
  def change
    change_table :ratings do |t|
      t.remove_references :user
      t.belongs_to :users
    end
  end
end
