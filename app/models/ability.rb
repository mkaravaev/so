class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      user.admin? ? admin_abilities : user_abilities(user)
    else
      quest_abilities      
    end
  end

  def user_abilities(user)
    can :read, :all
    can :create, [Question, Answer, Comment]
    can :update, [Question, Answer, Comment], user_id: user.id
  end

  def quest_abilities
    can :read, [Question, Answer, Comment]
  end

  def admin_abilities
    can :manage, :all
  end
end
