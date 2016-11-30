class Ability
  include CanCan::Ability

# only the user himself can update settings
  def initialize(user)

     can :update, User do |u|
        u == user
     end

     can :read, User do |u|
        u == user
     end
     
  end
end