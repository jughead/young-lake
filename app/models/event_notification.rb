class EventNotification < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates :user, presence: true, uniqueness: {scope: :event_id}
  validates :event, presence: true
  scope :not_sent, ->{ where(sent_at: nil) }
  scope :created_before, ->time{
    where(arel_table[:created_at].lt(time))
  }

  def mark_as_read
    self.is_read = true
    save
  end

  def mark_as_unread
    self.is_read = false
    save
  end

  def mark_as_sent
    self.sent_at = Time.zone.now
    save
  end

  def mark_as_sent!
    self.sent_at = Time.zone.now
    save!
  end

  def sent?
    !!sent_at
  end

  def read?
    is_read
  end

  def unread?
    !is_read
  end
end
