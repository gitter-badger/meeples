class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new

    if user.admin?
      can :manage, :all
    end

    cannot :destroy, User, id: user.id
    cannot :lock,    User, id: user.id
    cannot :unlock,  User, id: user.id
  end
end
