class GamePlayer < ActiveRecord::Base

  belongs_to :player, class: User
  belongs_to :play

end
