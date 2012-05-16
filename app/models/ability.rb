class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    
    case user.role
    when "admin"
      can :manage, :all
    when "member"
      can :read,   :all
      can :manage, Topic, creator_id: user.id
      can :create, Topic
      can :manage, Post, creator_id: user.id
    when "banned"
      can :read,   :all
    else # guest
      can :read,   :all
    end 
  end
end
