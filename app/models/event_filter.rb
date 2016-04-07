class EventFilter < ActiveRecord::Base
  belongs_to :theme
  belongs_to :city
  belongs_to :user

  before_validation :sanitize_start_range
  validates :user, presence: true
  validate :city_validator
  validate :theme_validator
  validate :non_empty_validator
  alias_attribute :with_city_id, :city_id
  alias_attribute :with_theme_id, :theme_id

  def with_start_at_between
    {from: start_at_from, to: start_at_to}
  end

  def with_start_at_between=(attrs)
    self.start_at_from = attrs[:from]
    self.start_at_to = attrs[:to]
  end

  def clear_filter_attributes
    self.start_at_to = nil
    self.start_at_from = nil
    self.city = nil
    self.theme = nil
  end

  def to_filterrific_params
    params = {}
    params[:with_start_at_between] = with_start_at_between
    params[:with_theme_id] = with_theme_id
    params[:with_city_id] = with_city_id
    params
  end

  private

    def sanitize_start_range
      if !start_at_from || !start_at_to || start_at_from && start_at_to && start_at_from > start_at_to
        self.start_at_from = nil
        self.start_at_to = nil
      end
    end

    def city_validator
      errors.add(:city, :blank) if city_id.present? && city.blank?
    end

    def theme_validator
      errors.add(:theme, :blank) if theme_id.present? && theme.blank?
    end

    def non_empty_validator
      errors.add(:base, :blank) and return if theme_id.blank? && city_id.blank? && start_at_from.blank? && start_at_to.blank?
    end

end
