class EmptyParams < Exception; end
class DateAlreadyReserved < Exception; end
class DateInPast < Exception; end


class CreateReservation
  attr_writer :reserved_at, :from, :to
  attr_reader :reservation, :errors

  def initialize(params)
    @params = params["text"]
    @errors = Sequel::Model::Errors.new
  end

  def create
    begin
      raise EmptyParams if empty_params?

      filter_params
    rescue DateAlreadyReserved, ArgumentError, DateInPast, EmptyParams => e
      @errors.add(:error, e)
    end
  end

  def persisted?
    @persisted
  end

  def success_message
    "Reservation made for #{@reserved_at} from: #{@from} - to: #{@to}"
  end

  def error_message
    "Sorry, errors occured: #{@errors}"
  end

  private

  def filter_params
    splited_string = @params.split('-')

    splited_date = splited_string[0].split('/')
    @reserved_at = Date.parse("#{Date.today.year}-#{splited_date[1]}-#{splited_date[0]}")
    @from = splited_string[1]
    @to = splited_string[2]

    raise DateAlreadyReserved if date_already_reserved?
    raise DateInPast if date_in_past?

    @reservation = Reservation.create(reserved_at: @reserved_at, from: @from, to: @to)
    @persisted = true
  end

  def date_already_reserved?
    reservations = Reservation.where(reserved_at: @reserved_at)
    return false if reservations.empty?
    reservations.each do |reservation|
      existing_range = reservation.from..reservation.to
      requested_range = @from..@to
      return true if existing_range.cover?(requested_range)
    end
  end

  def date_in_past?
    @reserved_at < Date.today
  end

  def empty_params?
    @params.empty?
  end

end
