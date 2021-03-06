class Ability

  include CanCan::Ability

  def initialize user
    if user
      can :manage, :all if user.admin?

      can :manage, Play,    user_id:   user.id
      can :manage, Comment, author_id: user.id

      can :friend, User do |friend|
        friend.id != user.id and !user.friend_ids.include?(friend.id)
      end

      cannot :destroy, User, id: user.id
      cannot :lock,    User, id: user.id
      cannot :unlock,  User, id: user.id
    end

    can :read, Game
    can :read, Play
  end

end
