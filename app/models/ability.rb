class Ability
  include CanCan::Ability

  def initialize(user)
    if user.manager?
      can :manage, :all
    else
      can :read, Event
      can [:index, :new, :create, :vote], Place
      can :manage, Vote
    end
  end
end