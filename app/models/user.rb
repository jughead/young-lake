class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :event_filter, inverse_of: :user
  has_many :events, dependent: :destroy
  has_many :event_notifications, dependent: :destroy

  def event_filter
    super || build_event_filter
  end
end
