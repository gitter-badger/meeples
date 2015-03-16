class AddedByToGames < ActiveRecord::Migration

  def change
    add_column :games, :added_by, :integer
  end

end
