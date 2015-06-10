module Trough
  class Ability
    include CanCan::Ability

    def initialize(user)

      can [:show], Document
      if user.try(:admin?)
        can :manage, :all
      end
    end
  end
end
