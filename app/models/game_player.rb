class GamePlayer < ActiveRecord::Base

  belongs_to :play
  belongs_to :player, class: User

end
