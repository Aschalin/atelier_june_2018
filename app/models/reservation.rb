class Reservation < ApplicationRecord
  require 'action_view'
  include ActionView::Helpers::DateHelper

  self.table_name = 'book_reservations'
  belongs_to :book
  belongs_to :user

  before_create :set_expiration
  before_update :set_expiration

  scope :active, -> { where(status: ['TAKEN', 'RESERVED']).order(created_at: :desc) }
  scope :completed, -> { where(status: 'RETURNED').order(created_at: :desc) }

  def taken?
    status == 'TAKEN'
  end

  def available?
    status == 'AVAILABLE'
  end

  def expires_in
    if (taken? || available?) && expires_at
      if expires_at < Time.now
        "#{expires_at.to_date} (expired #{distance_of_time_in_words(Time.now, expires_at)} ago)"
      else
        "#{expires_at.to_date} (#{distance_of_time_in_words(Time.now, expires_at)} left)"
      end
    else
      "-"
    end
  end

  private

  def set_expiration
    if taken?
      self.expires_at = Time.now + 2.weeks
    elsif available?
      self.expires_at = Time.now + 1.day
    end
  end
end
