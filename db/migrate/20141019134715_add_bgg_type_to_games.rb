class AddBggTypeToGames < ActiveRecord::Migration

  def change
    add_column :games, :bgg_type, :string
  end

end
