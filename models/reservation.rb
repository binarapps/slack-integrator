require "sequel"

class Reservation < Sequel::Model

  subset(:today, :reserved_at => Date.today)

  alias_method :save!, :save
  plugin :validation_helpers
  plugin :json_serializer

  def validate
    super
    validates_presence [:reserved_at, :from, :to]
  end

  def before_save
    raise DateAlreadyReserved if date_already_reserved?
  end

  private

  def date_already_reserved?
    reservations = Reservation.where(reserved_at: reserved_at)

    return false if reservations.empty?
    reservations.each do |reservation|
      @existing_range = reservation.from..reservation.to
      @requested_range = from..to
      return true if range_overlaps?
    end
    false
  end

  def range_overlaps?
    (@existing_range.first <= @requested_range.last) && (@requested_range.first <= @existing_range.last)
  end

end
