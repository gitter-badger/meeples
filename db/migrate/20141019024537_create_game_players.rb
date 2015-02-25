class CreateGamePlayers < ActiveRecord::Migration

  def change
    create_table :game_players do |t|
      t.belongs_to :player, index: true
      t.belongs_to :play, index: true

      t.timestamps
    end
  end

end
