class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user
    if user.role? :agent
      can :manage, Agent, :user_id => user.id
      can :read, @static_page
    else 
      can :read, @static_page
      if user.role? :admin
        can :manage, :all
      end
      if user.role? :subscriber
        can :manage, Person, :user_id => user.id
        can :read, @static_page
      end
    end
  end
end