class ChangeBggIdToString < ActiveRecord::Migration

  def change
    change_column :games, :bgg_id, :string
  end

end
