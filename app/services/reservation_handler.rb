class ReservationHandler
  # statuses: AVAILABLE, TAKEN, RESERVED, EXPIRED, CANCELED, RETURNED
  
  def initialize(user, book)
    @user = user
    @book = book
  end

  def reserve
    return "Book is not available for reservation" unless can_be_reserved?
    book.reservations.create(user: user, status: 'RESERVED')
  end

  def cancel_reservation
    book.reservations.where(user: user, status: 'RESERVED').order(created_at: :asc).first.update_attributes(status: 'CANCELED')
  end

  def take
    return unless can_be_taken?

    if available_reservation.present?
      available_reservation.update_attributes(status: 'TAKEN')
    else
      book.reservations.create(user: user, status: 'TAKEN')
    end
  end

  def can_be_reserved?
    book.reservations.find_by(user: user, status: 'RESERVED').nil?
  end

  def can_be_taken?
    not_taken? && ( available_for_user? || reservations.empty? )
  end

  def can_be_given_back?
    book.reservations.find_by(user: user, status: 'TAKEN').present?
  end

  def give_back
    ActiveRecord::Base.transaction do
      book.reservations.find_by(status: 'TAKEN').update_attributes(status: 'RETURNED')
      next_in_queue.update_attributes(status: 'AVAILABLE') if next_in_queue.present?
    end
  end

  private
  attr_reader :user, :book

  def not_taken?
    book.reservations.find_by(status: 'TAKEN').nil?
  end

  def available_for_user?
    if available_reservation.present?
      available_reservation.user == user
    else
      pending_reservations.nil?
    end
  end

  def pending_reservations
    book.reservations.find_by(status: 'PENDING')
  end

  def available_reservation
    book.reservations.find_by(status: 'AVAILABLE')
  end

  def next_in_queue
    book.reservations.where(status: 'RESERVED').order(created_at: :asc).first
  end
end