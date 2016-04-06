class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  validates :title, presence: true
  validates :user, presence: true
  validates :city_id, presence: true
  validates :city, presence: true
  validates :start_at, presence: true
  validates :finish_at, presence: true
  validates :description, presence: true
  has_and_belongs_to_many :themes
end
