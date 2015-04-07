class Ability
  include CanCan::Ability
  include Blacklight::Folders::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role?(:editor) || user.has_role?(:admin)
      can :manage, :all
    end
  end
end