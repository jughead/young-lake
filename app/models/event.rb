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
  validate :range_validator
  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    # Пока только по created_at
    order(arel_table[:created_at].send(direction))
  }

  scope :with_theme_id, ->theme_id{
    joins(:themes).where(themes: {id: theme_id})
  }

  scope :with_start_at_between, ->range_attrs{
    from = convert_to_time(range_attrs[:from])
    to = convert_to_time(range_attrs[:to])
    next unless from && to
    if from > to
      none
    else
      where(arel_table[:start_at].between(from..to))
    end
  }

  scope :with_city_id, ->city_id{ where(city_id: city_id) }

  filterrific default_filter_params: {sorted_by: 'created_at_desc'},
    available_filters: [
      :sorted_by,
      :with_theme_id,
      :with_start_at_between,
      :with_city_id,
    ]

  def self.options_for_city_id
    City.all
  end

  def self.convert_to_time(value)
    if value.is_a?(Time)
      value
    elsif value.is_a?(String)
      Time.zone.parse(value) rescue nil
    else
      nil
    end
  end

  private

    def range_validator
      errors.add(:start_at, :more_than_start) if start_at && finish_at && start_at >= finish_at
    end
end
