class CreatePlays < ActiveRecord::Migration

  def change
    create_table :plays do |t|
      t.belongs_to :game, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.string :description

      t.timestamps
    end
  end

end
