class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      can :update, Article do |article|
        article.user == user
      end
      can :destroy, Article do |article|
        article.user == user
      end
      can :update, Comment do |comment|
        comment.user == user
      end
      can :destroy, Comment do |comment|
        comment.user == user
      end
      can :create, Article
      can :create, Comment
      can :read, :all
    end

  end
end


# class Ability
#   include CanCan::Ability

#   def initialize(user)

#     if user.blank?
#       # not logged in

#       cannot :manage, :all
#       basic_read_only
#     elsif user.has_role?(:admin)
#       # admin

#       can :manage, :all
#     end

#   end

#   protected

#   def basic_read_only
#     can :read,    Topic
#     can :list,    Topic
#     can :search,  Topic
#   end
# end
