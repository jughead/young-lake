class Ability
  attr_reader :user
  include CanCan::Ability
  def initialize(user)
    @user = user
    @user ||= User.new
    event_abilities
  end

  def event_abilities
    can [:index, :show], Event
    if user.persisted?
      can [:use_stored_filter, :store_filter, :edit, :update, :new, :create, :delete], Event, user_id: user.id
    end
  end
end
