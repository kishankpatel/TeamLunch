class Ability
  include CanCan::Ability

  def initialize(user)
    if user.manager?
      can :manage, :all
    else
      can :manage, Place
      can :manage, Vote
      can :manage, EventPlace
    end
  end
end