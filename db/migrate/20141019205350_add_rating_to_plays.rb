class AddRatingToPlays < ActiveRecord::Migration

  def change
    add_column :plays, :rating, :integer
  end

end
