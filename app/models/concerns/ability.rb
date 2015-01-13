class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role?("admin") || user.has_role?("librarian")
      can :view_librarian_uis, :all
    end
  end
end