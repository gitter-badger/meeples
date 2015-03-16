class CreateFlagGamesJoinTable < ActiveRecord::Migration

  def change
    create_table :flag_games do |t|
      t.references :user, :game
      t.string :description
      t.index %i[game_id user_id], unique: true
    end
  end

end
