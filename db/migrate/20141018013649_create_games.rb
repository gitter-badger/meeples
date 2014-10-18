class CreateGames < ActiveRecord::Migration

  def change
    create_table :games do |t|
      t.integer :bgg_id
      t.integer :year_published
      t.string  :name,           null: false

      t.timestamps
    end
  end

end
