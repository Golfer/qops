class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)

      alias_action :create, :read, :update, :destroy, to: :crud
      alias_action :create, :update, :destroy, to: :modify

      if user.admin?
        can :create, [Quotation, Tag, Author]

      elsif user.api?
        can [:read,:create, :update], [Quotation, User, Tag]
      elsif user.moderator?
        can :modify, [Quotation, User, Tag]
      elsif user.author?

        can :crud, Quotation do |quotation|
          quotation.author == user
        end

        can [:create, :update], Tag do |tag|
          tag.author == user
        end

        cannot [:create, :update, :destroy], Category

      elsif user.banned?
        can :read, [Quotation, Tag]
      else
        can :read, :all
      end

    #WIKI
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
