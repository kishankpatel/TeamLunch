# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.manager?
      can :manage, :all
    else
      can :read, User
    end
  end
end